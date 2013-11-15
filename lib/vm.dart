
library yvm;

import "dart:mirrors";
import "dart:isolate";
import "dart:async";

part 'vm_router.dart';

class MSG
{
  static const _msgid='_message';
  static const _vmcontext='_vmcontext';
  static const _msgexception='_msgexception';
  static const _srckey='_srckey';
  static const _routekey='_routekey';
}

class _msg
{
  static const __init='__init';
  static const __error='__error';
  static const __inited='__inited';
  static const __router_setchild='__router_setchild';
}

class __init
{
  static const vmKey='___vmKey';
  static const myPort='___myPort';
  static const reportPort='___reportPort';
  static const ownerPort='___ownerPort';
  static const libraryName='___libraryName';
  static const className='___className';
  static const argumentList='___argumentList';
  static const classInstance='___classInstance';
}

class __error
{
  static const errKey='___errKey';
  static const errString='___errString';
  static const errObject='___errObject';
}

class __inited
{
  static const vmKey='___vmKey';
  static const vmContext='___vmContext';
  static const initMsg='___initMsg';
  static const initResult='___initResult';
}

class __router_setchild
{
  static const childKey='___childKey';
  static const childPort='___childPort';
}

void vm_main(Map<String,dynamic>initmsg)
{
  Map<String,dynamic> vm_context;

  //need init msg to initialize
  if (initmsg==null)
  {
    reportError({MSG._msgid:_msg.__error
                ,MSG._srckey:vm_context[__init.vmKey]
                ,__error.errKey:'vm_main:init'
                ,__error.errString:'init message is null'
                ,__error.errObject:initmsg},vm_context);
    return;
  }

  String msgid=initmsg[MSG._msgid];

  //create vm class instance
  if (vm_context==null&&msgid==_msg.__init)
  {
    vm_context={};
    vm_context.addAll(initmsg);
    vm_context.remove(MSG._msgid);
    var instance=vm_context[__init.classInstance]
                =CreateInstance(vm_context[__init.libraryName]
                                ,vm_context[__init.className]
                                ,vm_context[__init.argumentList]);
    if (instance==null)
    {
      reportError({MSG._msgid:_msg.__error
                  ,MSG._srckey:vm_context[__init.vmKey]
                  ,__error.errKey:'vm_main:instance'
                  ,__error.errString:'create instance failed'
                  ,__error.errObject:initmsg},vm_context);
      return;
    }

    //subscript message listener
    var myPort=vm_context[__init.myPort]=new ReceivePort();
    myPort.listen((Map<String,dynamic> msg){
        // message listener
        if (vm_context!=null)
        {
          if (msg!=null) msg[MSG._vmcontext]=vm_context;
          var classInstance=vm_context[__init.classInstance];
          if (classInstance!=null)
          {
            try
            {
              //invoke onMsg of vm class instance
              var result=classInstance.onMsg(msg);
            }
            catch(e)
            {
              msg[MSG._msgexception]=e;
              reportError({MSG._msgid:_msg.__error
                          ,MSG._srckey:vm_context[__init.vmKey]
                          ,__error.errKey:'vm_instance:process'
                          ,__error.errString:'cannot process message'
                          ,__error.errObject:msg},vm_context);
            }
            return;
          }
        }
        reportError({MSG._msgid:_msg.__error
                    ,MSG._srckey:vm_context[__init.vmKey]
                    ,__error.errKey:'vm_instance:context'
                    ,__error.errString:'vm context is not exist'
                    ,__error.errObject:msg},vm_context);

    });

    //try to invoke onInit of vm class instance
    dynamic initresult;
    try
    {
      initresult=instance.onInit(vm_context);
    }
    catch(e)
    {
      initresult=e;
    }

    //send inited message to ownerport
    SendPort ownerPort=vm_context[__init.ownerPort];
    if (ownerPort!=null)
      ownerPort.send({MSG._msgid:_msg.__inited
                      ,MSG._srckey:vm_context[__init.vmKey]
                      ,__inited.vmKey:vm_context[__init.vmKey]
                      ,__inited.initMsg:initmsg
                      ,__inited.initResult:initresult
                      ,__inited.vmContext:vm_context});
    else
      reportError({MSG._msgid:_msg.__error
                  ,MSG._srckey:vm_context[__init.vmKey]
                  ,__error.errKey:'vm_main:ownerport'
                  ,__error.errString:'cannot report init result'
                  ,__error.errObject:initmsg},vm_context);
    return;
  }


  reportError({MSG._msgid:_msg.__error
              ,__error.errKey:'vm_main:unhandled'
              ,__error.errString:'unhandled message'
              ,__error.errObject:initmsg},vm_context);
}

void reportError(dynamic errmsg,Map<String,dynamic> vm_context)
{
  if (vm_context!=null)
  {
    SendPort ownerPort=vm_context[__init.ownerPort];
    if (ownerPort!=null)
      {ownerPort.send(errmsg); return;}
  }
  throw new Exception(errmsg);
}

Future<Isolate> create_vm(String vmkey,Symbol libraryname,Symbol classname,List arguments,SendPort reportPort,SendPort ownerPort)
{
  var initmsg={MSG._msgid:_msg.__init
              ,MSG._srckey:''
              ,MSG._routekey:''
              ,__init.libraryName:libraryname
              ,__init.className:classname
              ,__init.argumentList:arguments
              ,__init.vmKey:vmkey
              ,__init.ownerPort:ownerPort
              ,__init.reportPort:reportPort};
  var fur= Isolate.spawn(vm_main, initmsg);
  return fur;
}

dynamic CreateInstance(Symbol libraryname,Symbol classname,List arguments)
{
  MirrorSystem curmirror = currentMirrorSystem();
  try
  {
    LibraryMirror libmirror = curmirror.findLibrary(libraryname);
    ClassMirror clsmirror = libmirror.declarations[classname];
    InstanceMirror insmirror = clsmirror.newInstance(const Symbol(''),arguments);
    return insmirror.reflectee;
  }
  catch (e)
  {
    return null;
  }
}

abstract class VMinterface
{
  void onInit(Map<String,dynamic> vmcontext);
  void onMsg(Map<String,dynamic> msg);
}

abstract class VMbase implements VMinterface
{
  String vmKey;
  SendPort ownerPort;
  SendPort reportPort;
  Map<String,dynamic> funcMap;

  void onInit(Map<String,dynamic> vm_context)
  {
    ownerPort=vm_context[__init.ownerPort];
    reportPort=vm_context[__init.reportPort];
    vmKey=vm_context[__init.vmKey];

    funcMap={};

  }
  void onMsg(Map<String,dynamic> msg)
  {
    var func=funcMap[msg[MSG._msgid]];
    if (func!=null)
      try
      {
        return func(msg);
      }
      catch (e)
      {
          this.reportError({MSG._msgid:_msg.__error
                            ,MSG._srckey:vmKey
                            ,MSG._msgexception:e
                            ,__error.errKey:'vm_class:onMsg'
                            ,__error.errString:'cannot deliver message'
                            ,__error.errObject:msg});
      }
  }

  void postMsg(Map<String,dynamic> msg)
  {
    if (reportPort!=null&&msg!=null)
      reportPort.send(msg..[MSG._srckey]=vmKey);
  }
  void returnMsg(Map<String,dynamic> msg)
  {
    if (ownerPort!=null)
      ownerPort.send(msg..[MSG._srckey]=vmKey);
  }

  void registerMsg(String msgid,void msgHandler(Map<String,dynamic> msg))
  {
    funcMap[msgid]=msgHandler;
  }

  void unregisterMsg(String msgid)
  {
    funcMap.remove(msgid);
  }

  void reportError(dynamic errmsg)
  {
    if (ownerPort!=null)
      {ownerPort.send(errmsg); return;}
    throw new Exception(errmsg);
  }
}
