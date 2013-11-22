part of yvm;

abstract class VMinterface
{
  void onInit(Map<String,dynamic> vmcontext);
  void onMsg(Map<String,dynamic> msg);
}

abstract class VMbase implements VMinterface
{
  String _vmKey;
  SendPort _ownerPort;
  SendPort _reportPort;
  Map<String,dynamic> _funcMap;
  Map<String,dynamic> _vmContext;

  VMbase()
  {
    _funcMap={};
  }

  void onInit(Map<String,dynamic> vm_context)
  {
    _ownerPort=vm_context[MSG_INIT.ownerPort];
    _reportPort=vm_context[MSG_INIT.reportPort];
    _vmKey=vm_context[MSG_INIT.vmKey];

    // funcMap={};

  }
  void onMsg(Map<String,dynamic> msg)
  {
    var func=_funcMap[msg[MSG.k_msgid]];
    if (func!=null)
      try
      {
        _vmContext=msg[MSG.k_vmcontext];
        return func(msg);
      }
      catch (e)
      {
          this.reportError({MSG.k_msgid:INT_MSG.k__error
                            ,MSG.k_srckey:_vmKey
                            ,MSG.k_msgexception:e
                            ,MSG_ERROR.errKey:'vm_class:onMsg'
                            ,MSG_ERROR.errString:'cannot deliver message'
                            ,MSG_ERROR.errObject:msg});
      }
  }

  void postMsg(Map<String,dynamic> msg)
  {
    if (_reportPort!=null&&msg!=null)
      _reportPort.send(msg..[MSG.k_srckey]=_vmKey
                         ..[MSG.k_srcmsgid]=_vmContext[MSG_INIT.sourceMsgID]);
  }
  void returnMsg(Map<String,dynamic> msg)
  {
    if (_ownerPort!=null)
      _ownerPort.send(msg..[MSG.k_srckey]=_vmKey
                        ..[MSG.k_srcmsgid]=_vmContext[MSG_INIT.sourceMsgID]);
  }

  void registerMsg(String msgid,void msgHandler(Map<String,dynamic> msg))
  {
    _funcMap[msgid]=msgHandler;
  }

  void unregisterMsg(String msgid)
  {
    _funcMap.remove(msgid);
  }

  void reportError(dynamic errmsg)
  {
    if (_ownerPort!=null)
      {_ownerPort.send(errmsg); return;}
    throw new Exception(errmsg);
  }
}