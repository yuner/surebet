
library vm;

import "dart:mirrors";
import "dart:isolate";
import "dart:async";

const _msgid='_message';
const _vmcontext='_vmcontext';
const _msgexception='_msgexception';

abstract class VMbase
{
  void onInit(Map<String,dynamic> vmcontext);
  void onMsg(Map<String,dynamic> msg);
}

class _msg extends Expando
{
  static const __init='__init';
  static const __error='__error';
  static const __inited='__inited';
}

class __init extends Expando
{
  static const vmKey='_vmKey';
  static const myPort='_myPort';
  static const reportPort='_reportPort';
  static const ownerPort='_ownerPort';
  static const libraryName='_libraryName';
  static const className='_className';
  static const argumentList='_argumentList';
  static const classInstance='_classInstance';
}

class __error extends Expando
{
  static const errKey='_errKey';
  static const errString='_errString';
  static const errObject='_errObject';
}

class __inited extends Expando
{
  static const vmKey='_vmKey';
  static const vmContext='_vmContext';
  static const initMsg='_initMsg';
  static const initResult='_initResult';
}

void vm_main(Map<String,dynamic>initmsg)
{
  Map<String,dynamic> vm_context;

  if (initmsg==null)
  {
    reportError({_msgid:_msg.__error
                ,__error.errKey:'vm_main:init'
                ,__error.errString:'init message is null'
                ,__error.errObject:initmsg},vm_context);
    return;
  }

  String msgid=initmsg[_msgid];

  //create class instance
  if (vm_context==null&&msgid==_msg.__init)
  {
    vm_context={};
    vm_context.addAll(initmsg);
    vm_context.remove(_msgid);
    var instance=vm_context[__init.classInstance]
                =CreateInstance(vm_context[__init.libraryName]
                                ,vm_context[__init.className]
                                ,vm_context[__init.argumentList]);
    if (instance==null)
    {
      reportError({_msgid:_msg.__error
                  ,__error.errKey:'vm_main:instance'
                  ,__error.errString:'create instance failed'
                  ,__error.errObject:initmsg},vm_context);
      return;
    }

    //subscript message listener
    var myPort=vm_context[__init.myPort]=new ReceivePort();
    myPort.listen((Map<String,dynamic> msg){
        if (vm_context!=null)
        {
          if (msg!=null) msg[_vmcontext]=vm_context;
          var classInstance=vm_context[__init.classInstance];
          if (classInstance!=null)
          {
            try
            {
              var result=classInstance.onMsg(msg);
            }
            catch(e)
            {
              msg[_msgexception]=e;
              reportError({_msgid:_msg.__error
                          ,__error.errKey:'vm_instance:process'
                          ,__error.errString:'cannot process message'
                          ,__error.errObject:msg},vm_context);
            }
            return;
          }
        }
        reportError({_msgid:_msg.__error
                    ,__error.errKey:'vm_instance:context'
                    ,__error.errString:'vm context is not exist'
                    ,__error.errObject:msg},vm_context);

    });

    //try to invoke onInit
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
      ownerPort.send({_msgid:_msg.__inited
                      ,__inited.vmKey:vm_context[__init.vmKey]
                      ,__inited.initMsg:initmsg
                      ,__inited.initResult:initresult
                      ,__inited.vmContext:vm_context});
    else
      reportError({_msgid:_msg.__error
                  ,__error.errKey:'vm_main:ownerport'
                  ,__error.errString:'cannot report init result'
                  ,__error.errObject:initmsg},vm_context);
    return;
  }

  /*
  else if (vm_context!=null)
  {
    ReceivePort myPort=vm_context[__init.myPort];
    var classInstance=vm_context[__init.classInstance];
    if (myPort!=null)
      myPort.sendPort.send(initmsg);
    else if (classInstance!=null)
      classInstance.onMsg(initmsg);
    else
      reportError({_msgid:_msg.__error
                  ,__error.errKey:'vm_main:myport'
                  ,__error.errString:'cannot deliver message'
                  ,__error.errObject:initmsg},vm_context);
    return;
  }
  */

  reportError({_msgid:_msg.__error
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
      ownerPort.send(errmsg);
  }
  throw new Exception(errmsg);
}

Future<Isolate> create_vm(String vmkey,Symbol libraryname,Symbol classname,List arguments,SendPort reportPort,SendPort ownerPort)
{
  var initmsg={_msgid:_msg.__init
              ,__init.vmKey:vmkey
              ,__init.libraryName:libraryname
              ,__init.className:classname
              ,__init.argumentList:arguments
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