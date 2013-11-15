
part of yvm;

class VMS
{
  static const _rtcondition='_rtcondition';
  static const _rtexecution='_rtexecution';
  static const _rtsourcekey='_rtsourcekey';
  static const owner='#owner#';
  static const report='#report#';
}

class CDB
{
  static const _vminstanc='_vminstanc';
  static const _sourcemsg='_sourcemsg';
  static const _localstat='_localstat';
}

class ECB
{
  static const _vminstanc='_vminstanc';
  static const _sourcemsg='_sourcemsg';
  static const _localstat='_localstat';
}

class ECR
{
  static const _sourcemsg='_sourcemsg';
}

class NestObject
{
  static GetNestObjectByString(dynamic obj,String path)
  {
    if (path==null||obj==null) return null;
    var pathlist=path.split('.');
    return NestObject.GetNestObjectByList(obj,pathlist);
  }

  static GetNestObjectByList(dynamic obj,List<String> pathlist)
  {
    if (pathlist==null||obj==null) return null;

    if (pathlist.length>1)
    {
      var newobj=GetObjectField(obj,pathlist[0]);
      if (newobj!=null)
        return GetNestObjectByList(newobj,pathlist);
    }
    else if (pathlist.length>0)
    {
      return GetObjectField(obj,pathlist[0]);
    }
    return null;
  }

  static GetObjectField(dynamic obj,String key)
  {
    var refobj=reflect(obj);
    if (refobj.getField(const Symbol('[]'))!=null)
      return obj[key];
    else
    {
      var refval=refobj.getField(new Symbol(key));
      if (refval!=null)
        return refval.reflectee;
    }
    return null;
  }

  static void SetNestObjectByString(dynamic obj,String path,value)
  {
    if (path==null||obj==null) return null;
    var pathlist=path.split('.');
    NestObject.SetNestObjectByList(obj,pathlist,value);
  }

  static void SetNestObjectByList(dynamic obj,List<String> pathlist,value)
  {
    if (pathlist==null||obj==null) return null;

    if (pathlist.length>1)
    {
      var newobj=GetObjectField(obj,pathlist[0]);
      newobj=(newobj==null)?{}:newobj;
      SetNestObjectByList(newobj,pathlist,value);
    }
    else if (pathlist.length>0)
    {
      SetObjectField(obj,pathlist[0],value);
    }
  }

  static SetObjectField(dynamic obj,String key,value)
  {
    var refobj=reflect(obj);
    if (refobj.getField(const Symbol('[]='))!=null)
      obj[key]=value;
    else
      var refval=refobj.setField(new Symbol(key), value);
  }
}

class condBroker extends Expando
{
  dynamic get_local_stat(String key)
  {
    Map<String,dynamic> stat=this[CDB._localstat];
    return stat[key];
  }

  dynamic get_msg_value(String path)
  {
    Map<String,dynamic> msg=this[CDB._sourcemsg];
  }
}

class execBroker extends Expando
{

  void set_local_stat(String key,dynamic value)
  {
    Map<String,dynamic> stat=this[ECB._localstat];
    stat[key]=value;
  }

  dynamic get_local_stat(String key)
  {
    Map<String,dynamic> stat=this[ECB._localstat];
    return stat[key];
  }

  dynamic unset_local_stat(String key)
  {
    Map<String,dynamic> stat=this[ECB._localstat];
    return stat.remove(key);
  }

  Map<String,dynamic> generate_msg(Map<String,dynamic> sourceMsg,[Map<String,String> translateMap])
  {
    var targetMsg=null;
    var targetMap=(translateMap==null?{}.addAll(sourceMsg):{});
    if (translateMap!=null)
    {
      targetMsg={MSG._msgid:sourceMsg[MSG._msgid]
                ,MSG._srckey:sourceMsg[MSG._srckey]};
      translateMap.forEach((String sourceKey,String targetKey){
        var value=NestObject.GetNestObjectByString(sourceMsg, sourceKey);
        NestObject.SetNestObjectByString(targetMsg, targetKey, value);
      });
    }
   return targetMsg;
  }

  void send_msg(String vmKey,Map<String,dynamic> targetMsg)
  {
    VMrouter router=this[ECB._vminstanc];
    if (router!=null)
      router.sendMsg(vmKey,targetMsg);
  }

}

abstract class execResult extends Expando
{

}


abstract class VMrouter implements VMinterface
{
  String vmKey;
  SendPort ownerPort;
  SendPort reportPort;
  Map<RegExp,Map<String,dynamic>> listenerMap;
  Map<String,SendPort> childrenMap;
  Map<String,dynamic> localStats;

  void onInit(Map<String,dynamic> vm_context)
  {
    ownerPort=vm_context[__init.ownerPort];
    reportPort=vm_context[__init.reportPort];
    vmKey=vm_context[__init.vmKey];

    listenerMap={};
    childrenMap={};
  }

  void onMsg(Map<String,dynamic> msg)
  {
    String msgid=msg[MSG._msgid];
    String srckey=msg[MSG._srckey];
    if (msgid==null) return;
    switch(msgid)
    {
      case _msg.__router_setchild:
        this.setChildPort(msg[__router_setchild.childKey],msg[__router_setchild.childKey]);
        break;
      default:
        for (var msgpattern in listenerMap.keys)
        {
          if (msgpattern.hasMatch(msgid))
          {
            var listener=listenerMap[msgpattern];
            RegExp rtsourcekey=listener[VMS._rtsourcekey];
            var rtcondition=listener[VMS._rtcondition];
            var rtexecution=listener[VMS._rtexecution];

            if (rtsourcekey!=null)
              if (!rtsourcekey.hasMatch(srckey))
                continue;

            if (rtcondition!=null)
              try
              {
                if (!rtcondition(new condBroker()..[CDB._vminstanc]=this
                                                  ..[CDB._sourcemsg]=msg
                                                  ..[CDB._localstat]=localStats))
                  continue;
              }
              catch (e)
              {
                this.reportError({MSG._msgid:_msg.__error
                  ,MSG._srckey:vmKey
                  ,MSG._msgexception:e
                  ,__error.errKey:'vm_router:condition'
                  ,__error.errString:'cannot eval message'
                  ,__error.errObject:msg});
              }

            if (rtexecution!=null)
              try
              {
                if (rtcondition(new execBroker()..[ECB._vminstanc]=this
                                                ..[ECB._sourcemsg]=msg
                                                ..[ECB._localstat]=localStats)!=null)
                {
                  //for future
                }
                continue;
              }
              catch (e)
              {
                this.reportError({MSG._msgid:_msg.__error
                  ,MSG._srckey:vmKey
                  ,MSG._msgexception:e
                  ,__error.errKey:'vm_router:execution'
                  ,__error.errString:'cannot exec message'
                  ,__error.errObject:msg});
            }
          }
        }
        break;
    }
  }

  void sendMsg(String vmKey,Map<String,dynamic> msg)
  {
    SendPort port;
    if (vmKey==VMS.owner) port=ownerPort;
    else if (vmKey==VMS.report) port=reportPort;
    else port=childrenMap[vmKey];
    if (port!=null)
    {
      port.send(msg..[MSG._routekey]=vmKey);
    }
  }

  Iterable<RegExp> get msgPatterns => listenerMap.keys;
  Iterable<RegExp> getMsgPattern(String msgString)
  {
    listenerMap.keys.where((RegExp msgPattern)=>msgPattern==msgString);
  }

  void setRule(RegExp msgPattern,[String sourceKey,bool condition(condBroker),execResult execution(execBroker)])
  {
    listenerMap[msgPattern]={VMS._rtsourcekey:sourceKey
                            ,VMS._rtcondition:condition
                            ,VMS._rtexecution:execution};
  }
  Map<String,dynamic> getRule(RegExp msgPattern)
  {
    return listenerMap[msgPattern];
  }

  Map<String,dynamic> unsetRule(RegExp msgPattern)
  {
    return listenerMap[msgPattern];
  }

  void setChildPort(String vmKey,SendPort port)
  {
    childrenMap[vmKey]=port;
  }

  SendPort getChildPort(String vmKey)
  {
    return childrenMap[vmKey];
  }

  SendPort unsetChildPort(String vmKey)
  {
    return childrenMap.remove(vmKey);
  }

  void reportError(dynamic errmsg)
  {
    if (ownerPort!=null)
      {ownerPort.send(errmsg); return;}
    throw new Exception(errmsg);
  }
}