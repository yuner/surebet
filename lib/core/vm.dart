
library yvm;

//import "dart:mirrors";
import "dart:isolate";
import "dart:async";

import 'struct/message.dart' as MSG;

import 'internal_messages.dart' as INT_MSG;

import 'struct/intmsg/init.dart' as MSG_INIT;
import 'struct/intmsg/error.dart' as MSG_ERROR;
import 'struct/intmsg/inited.dart' as MSG_INITED;
import 'struct/intmsg/update.dart' as MSG_UPDATE;

import 'struct/intmsg/update/rules.dart' as M_UPDATE_RULES;
import 'struct/intmsg/update/stats.dart' as M_UPDATE_STATS;
import 'struct/intmsg/update/child.dart' as M_UPDATE_CHILD;

import 'struct/router/routerule.dart' as VMS;
import 'struct/router/condbroker.dart' as CDB;
import 'struct/router/execbroker.dart' as ECB;
import 'struct/router/execresult.dart' as ECR;

//import 'func/nestobjecthelper.dart' as NestObject;
import 'func/createinstancehelper.dart';

part 'vm_router.dart';
part 'vm_base.dart';

// move to struct/message.dart
/*
class MSG
{
  static const k_msgid='_message';
  static const k_vmcontext='_vmcontext';
  static const k_msgexception='_msgexception';
  static const k_srckey='_srckey';
  static const k_routekey='_routekey';
  static const k_srcmsgid='_srcmsgid';
}
*/

// move to internal_messages.dart
/*
class _msg
{
  static const k__init='__init';
  static const k__error='__error';
  static const k__inited='__inited';
  static const k__update='__update';
}
*/

// move to struct/intmsg/init.dart
/*
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
  static const sourceMsgID='___sourceMsgID';
  static const procBegin='___procBegin';
  static const procEnd='___procEnd';
  static const elapsedTime='___elapsedTime';
}
*/

// move to struct/intmsg/error.dart
/*
class __error
{
  static const errKey='___errKey';
  static const errString='___errString';
  static const errObject='___errObject';
}
*/

// move to struct/intmsg/inited.dart
/*
class __inited
{
  static const vmKey='___vmKey';
  static const vmContext='___vmContext';
  static const initMsg='___initMsg';
  static const initResult='___initResult';
}
*/

// move to struct/intmsg/update.dart
/*
class __update
{
  static const rules='___rules';
  static const stats='___stats';
  static const child='___child';
}
*/

// move to struct/intmsg/update/rules.dart
/*
class ___rtrules
{
  static const msgPattern='____msgPattern';
  static const sourceKey='____sourceKey';
  static const ruleCondition='____ruleCondition';
  static const ruleExecution='____ruleExecution';
}
*/

// move to struct/intmsg/update/stats.dart
/*
class ___rtstats
{
  static const statKey='____statKey';
  static const statValue='____statValue';
  static const isUnset='____isUnset';
}
*/

// move to struct/intmsg/update/child.dart
/*
class ___rtchild
{
  static const childKey='____childKey';
  static const ChildPort='____ChildPort';
}
*/

main(args, message)
{
  vm_main(message);
}

void vm_main(Map<String,dynamic>initmsg)
{
  Map<String,dynamic> _vm_context;

  //need init msg to initialize
  if (initmsg==null)
  {
    reportError({MSG.k_msgid:INT_MSG.k__error
                ,MSG.k_srckey:_vm_context[MSG_INIT.vmKey]
                ,MSG_ERROR.errKey:'vm_main:init'
                ,MSG_ERROR.errString:'init message is null'
                ,MSG_ERROR.errMessage:initmsg},_vm_context);
    return;
  }

  String msgid=initmsg[MSG.k_msgid];

  //create vm class instance
  if (_vm_context==null&&msgid==INT_MSG.k__init)
  {
    _vm_context={};
    _vm_context.addAll(initmsg);
    _vm_context.remove(MSG.k_msgid);
    var instance=_vm_context[MSG_INIT.classInstance]
                =CreateInstance(_vm_context[MSG_INIT.libraryName]
                                ,_vm_context[MSG_INIT.className]
                                ,_vm_context[MSG_INIT.argumentList]);
    if (instance==null)
    {
      reportError({MSG.k_msgid:INT_MSG.k__error
                  ,MSG.k_srckey:_vm_context[MSG_INIT.vmKey]
                  ,MSG_ERROR.errKey:'vm_main:instance'
                  ,MSG_ERROR.errString:'create instance failed'
                  ,MSG_ERROR.errMessage:initmsg},_vm_context);
      return;
    }

    //subscript message listener
    var myPort=_vm_context[MSG_INIT.myPort]=new ReceivePort();
    myPort.listen((Map<String,dynamic> msg){
        // message listener
        if (_vm_context!=null)
        {
          if (msg!=null) msg[MSG.k_vmcontext]=_vm_context;
          var classInstance=_vm_context[MSG_INIT.classInstance];
          if (classInstance!=null)
          {
            try
            {
              //invoke onMsg of vm class instance
              var elapsed=new Stopwatch();
              _vm_context[MSG_INIT.sourceMsgID]=msg[MSG.k_srcmsgid];
              _vm_context[MSG_INIT.procBegin]=new DateTime.now();
              elapsed.start();
              var result=classInstance.onMsg(msg);
              elapsed.stop();
              _vm_context[MSG_INIT.elapsedTime]=elapsed.elapsedMilliseconds;
              _vm_context[MSG_INIT.procEnd]=new DateTime.now();
            }
            catch(e)
            {
              msg[MSG.k_msgexception]=e;
              reportError({MSG.k_msgid:INT_MSG.k__error
                          ,MSG.k_srckey:_vm_context[MSG_INIT.vmKey]
                          ,MSG_ERROR.errKey:'vm_instance:process'
                          ,MSG_ERROR.errString:'cannot process message'
                          ,MSG_ERROR.errMessage:msg},_vm_context);
            }
            return;
          }
        }
        reportError({MSG.k_msgid:INT_MSG.k__error
                    ,MSG.k_srckey:_vm_context[MSG_INIT.vmKey]
                    ,MSG_ERROR.errKey:'vm_instance:context'
                    ,MSG_ERROR.errString:'vm context is not exist'
                    ,MSG_ERROR.errMessage:msg},_vm_context);

    });

    //try to invoke onInit of vm class instance
    dynamic initresult;
    try
    {
      initresult=instance.onInit(_vm_context);
    }
    catch(e)
    {
      initresult=e;
    }

    //send inited message to ownerport
    SendPort ownerPort=_vm_context[MSG_INIT.ownerPort];
    if (ownerPort!=null)
      ownerPort.send({MSG.k_msgid:INT_MSG.k__inited
                      ,MSG.k_srckey:_vm_context[MSG_INIT.vmKey]
                      ,MSG_INITED.vmKey:_vm_context[MSG_INIT.vmKey]
                      ,MSG_INITED.initMsg:initmsg
                      ,MSG_INITED.initResult:initresult
                      ,MSG_INITED.vmContext:_vm_context});
    else
      reportError({MSG.k_msgid:INT_MSG.k__error
                  ,MSG.k_srckey:_vm_context[MSG_INIT.vmKey]
                  ,MSG_ERROR.errKey:'vm_main:ownerport'
                  ,MSG_ERROR.errString:'cannot report init result'
                  ,MSG_ERROR.errMessage:initmsg},_vm_context);
    return;
  }


  reportError({MSG.k_msgid:INT_MSG.k__error
              ,MSG_ERROR.errKey:'vm_main:unhandled'
              ,MSG_ERROR.errString:'unhandled message'
              ,MSG_ERROR.errMessage:initmsg},_vm_context);
}

void reportError(dynamic errmsg,Map<String,dynamic> vm_context)
{
  if (vm_context!=null)
  {
    SendPort ownerPort=vm_context[MSG_INIT.ownerPort];
    if (ownerPort!=null)
      {ownerPort.send(errmsg); return;}
  }
  throw new Exception(errmsg);
}

Future<Isolate> create_vm(String vmkey,Symbol libraryname,Symbol classname,List classargs,SendPort reportPort,SendPort ownerPort
                          ,[Uri uri,List<String> mainargs])
{
  var initmsg={MSG.k_msgid:INT_MSG.k__init
              ,MSG.k_srckey:''
              ,MSG.k_routekey:''
              ,MSG_INIT.libraryName:libraryname
              ,MSG_INIT.className:classname
              ,MSG_INIT.argumentList:classargs
              ,MSG_INIT.vmKey:vmkey
              ,MSG_INIT.ownerPort:ownerPort
              ,MSG_INIT.reportPort:reportPort};
  Future<Isolate> fur;
  if (uri==null)
    fur= Isolate.spawn(vm_main, initmsg);
  else
    fur=Isolate.spawnUri(uri, mainargs, initmsg);
  return fur;
}

