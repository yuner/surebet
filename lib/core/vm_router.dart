
part of yvm;

// move to struct/router/routerule.dart
/*
class VMS
{
  static const k_rtcondition='_rtcondition';
  static const k_rtexecution='_rtexecution';
  static const k_rtsourcekey='_rtsourcekey';
  static const owner='#owner#';
  static const report='#report#';
}
*/

// move to struct/router/condbroker.dart
/*
class CDB
{
  static const k_vminstanc='_vminstanc';
  static const k_sourcemsg='_sourcemsg';
  static const k_localstat='_localstat';
}
*/

// move to struct/router/execbroker.dart
/*
class ECB
{
  static const k_vminstanc='_vminstanc';
  static const k_sourcemsg='_sourcemsg';
  static const k_localstat='_localstat';
}
*/

// move to struct/router/execresult.dart
/*
class ECR
{
  static const k_sourcemsg='_sourcemsg';
  static const k_localstat='_localstat';
}
*/

//move to func/nestobjecthelper
/*
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
*/



class ExpandoMe<Tkey, Tval>
{
  Map<Tkey,Tval> _localMap={};
  Tval operator[](Tkey key)=>_localMap[key];
  void operator[]=(Tkey key,Tval val){_localMap[key]=val;}
}

class condBroker extends ExpandoMe
{
  dynamic get_local_stat(String key)
  {
    Map<String,dynamic> stat=this[CDB.k_localstat];
    return stat[key];
  }

  dynamic get_msg_value(String path)
  {
    Map<String,dynamic> msg=this[CDB.k_sourcemsg];
  }
}

class execBroker extends ExpandoMe
{

  void set_local_stat(String key,dynamic value)
  {
    Map<String,dynamic> stat=this[ECB.k_localstat];
    stat[key]=value;
  }

  dynamic get_local_stat(String key)
  {
    Map<String,dynamic> stat=this[ECB.k_localstat];
    return stat[key];
  }

  dynamic unset_local_stat(String key)
  {
    Map<String,dynamic> stat=this[ECB.k_localstat];
    return stat.remove(key);
  }

  Map<String,dynamic> generate_msg(Map<String,dynamic> sourceMsg,[Map<String,String> translateMap])
  {
    var targetMsg=null;
    var targetMap=(translateMap==null?{}.addAll(sourceMsg):{});
    if (translateMap!=null)
    {
      targetMsg={MSG.k_msgid:sourceMsg[MSG.k_msgid]
                ,MSG.k_srcmsgid:sourceMsg[MSG.k_srcmsgid]
                ,MSG.k_srckey:sourceMsg[MSG.k_srckey]};
      translateMap.forEach((String sourceKey,String targetKey){
        var value=NestObject.GetNestObjectByString(sourceMsg, sourceKey);
        NestObject.SetNestObjectByString(targetMsg, targetKey, value);
      });
    }
   return targetMsg;
  }

  void send_msg(String vmKey,Map<String,dynamic> targetMsg)
  {
    VMrouter router=this[ECB.k_vminstanc];
    if (router!=null)
      router.sendMsg(vmKey,targetMsg);
  }

}

class execResult extends ExpandoMe
{
  Map<String,dynamic> updateStats(Map<String,dynamic> localStats)
  {
    return this[ECR.k_localstat];
  }
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
    ownerPort=vm_context[MSG_INIT.ownerPort];
    reportPort=vm_context[MSG_INIT.reportPort];
    vmKey=vm_context[MSG_INIT.vmKey];

    listenerMap={};
    childrenMap={};
  }

  void onMsg(Map<String,dynamic> msg)
  {
    String msgid=msg[MSG.k_msgid];
    String srckey=msg[MSG.k_srckey];
    if (msgid==null) return;
    switch(msgid)
    {
      case INT_MSG.k__update:
        List<Map<String,dynamic>> stats=msg[MSG_UPDATE.stats];
        List<Map<String,dynamic>> rules=msg[MSG_UPDATE.rules];
        List<Map<String,dynamic>> child=msg[MSG_UPDATE.child];
        if (stats!=null)
          for (var stat in stats)
          {
            String key=stat[M_UPDATE_STATS.statKey];
            dynamic value=stat[M_UPDATE_STATS.statValue];
            bool unset=stat[M_UPDATE_STATS.isUnset];

            if (unset)
              unsetLocalStat(key);
            else
              setLocalStat(key,value);
          }
        if (rules!=null)
          for (var rule in rules)
          {
            String msgString=rule[M_UPDATE_RULES.msgPattern];
            String sourceKey=rule[M_UPDATE_RULES.sourceKey];
            String condition=rule[M_UPDATE_RULES.ruleCondition];
            String execution=rule[M_UPDATE_RULES.ruleExecution];
            if (msgString!=null)
            {
              var msgPatterns=getMsgPattern(msgString);
              var condFunc=parseCondition(condition);
              var execFunc=parseExecution(execution);
              if (execution==null)
                msgPatterns.forEach((msgPattern){
                  unsetRule(msgPattern);
                });
              else
                msgPatterns.forEach((msgPattern){
                  setRule(msgPattern, sourceKey, condFunc, execFunc);
                });
            }
          }
        if (child!=null)
          for (var chil in child)
          {
            String key=chil[M_UPDATE_CHILD.childKey];
            SendPort port=chil[M_UPDATE_CHILD.ChildPort];

            if (port==null)
              unsetChildPort(key);
            else
              setChildPort(key,port);
          }
        break;
      default:
        for (var msgpattern in listenerMap.keys)
        {
          if (msgpattern.hasMatch(msgid))
          {
            var listener=listenerMap[msgpattern];
            RegExp rtsourcekey=listener[VMS.k_rtsourcekey];
            var rtcondition=listener[VMS.k_rtcondition];
            var rtexecution=listener[VMS.k_rtexecution];

            if (rtsourcekey!=null)
              if (!rtsourcekey.hasMatch(srckey))
                continue;

            if (rtcondition!=null)
              try
              {
                if (!rtcondition(new condBroker()..[CDB.k_vminstanc]=this
                                                  ..[CDB.k_sourcemsg]=msg
                                                  ..[CDB.k_localstat]={}.addAll(localStats)))
                  continue;
              }
              catch (e)
              {
                this.reportError({MSG.k_msgid:INT_MSG.k__error
                  ,MSG.k_srckey:vmKey
                  ,MSG.k_msgexception:e
                  ,MSG_ERROR.errKey:'vm_router:condition'
                  ,MSG_ERROR.errString:'cannot eval message'
                  ,MSG_ERROR.errObject:msg});
              }

            if (rtexecution!=null)
              try
              {
                execResult result=rtexecution(new execBroker()..[ECB.k_vminstanc]=this
                                                        ..[ECB.k_sourcemsg]=msg
                                                        ..[ECB.k_localstat]={}.addAll(localStats));
                if (result!=null)
                {
                  localStats=result.updateStats(localStats);
                }
                continue;
              }
              catch (e)
              {
                this.reportError({MSG.k_msgid:INT_MSG.k__error
                  ,MSG.k_srckey:vmKey
                  ,MSG.k_msgexception:e
                  ,MSG_ERROR.errKey:'vm_router:execution'
                  ,MSG_ERROR.errString:'cannot exec message'
                  ,MSG_ERROR.errObject:msg});
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
      port.send(msg..[MSG.k_routekey]=vmKey);
    }
  }

  Iterable<RegExp> get msgPatterns => listenerMap.keys;
  Iterable<RegExp> getMsgPattern(String msgString)
  {
    listenerMap.keys.where((RegExp msgPattern)=>msgPattern==msgString);
  }

  void setRule(RegExp msgPattern,[String sourceKey,bool condition(condBroker),execResult execution(execBroker)])
  {
    listenerMap[msgPattern]={VMS.k_rtsourcekey:sourceKey
                            ,VMS.k_rtcondition:condition
                            ,VMS.k_rtexecution:execution};
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

  void setLocalStat(String key,value)
  {
    localStats[key]=value;
  }

  dynamic getLocalStat(String key)
  {
    return localStats[key];
  }

  dynamic unsetLocalStat(String key)
  {
    return localStats.remove(key);
  }

  dynamic parseCondition(String funcode)
  {

  }
  dynamic parseExecution(String funcode)
  {
    //send message
    //change stats
  }

  void reportError(dynamic errmsg)
  {
    if (ownerPort!=null)
      {ownerPort.send(errmsg); return;}
    throw new Exception(errmsg);
  }
}