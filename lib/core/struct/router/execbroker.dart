library execbroker;

import '../message.dart' as MSG;

import '../../vm.dart';
import '../../../data/base.dart';
import '../../func/nestobjecthelper.dart' as NestObject;

import 'routerule.dart';

 const k_vminstanc='_vminstanc';
 const k_sourcemsg='_sourcemsg';
 const k_localstat='_localstat';

 class execBrokerBag
 {
    VMrouter vminstanc;
    IDkey sourcemsg;
    Map<String,dynamic> localstat;
 }

 class execBroker extends Object with ExpandoMe
 {

   void set_local_stat(String key,dynamic value)
   {
     Map<String,dynamic> stat=this[k_localstat];
     stat[key]=value;
   }

   dynamic get_local_stat(String key)
   {
     Map<String,dynamic> stat=this[k_localstat];
     return stat[key];
   }

   dynamic unset_local_stat(String key)
   {
     Map<String,dynamic> stat=this[k_localstat];
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
     VMrouter router=this[k_vminstanc];
     if (router!=null)
       router.sendMsg(vmKey,targetMsg);
   }

 }
