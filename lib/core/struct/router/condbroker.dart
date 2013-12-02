library condbroker;

import '../../vm.dart';
import '../../../data/base.dart';

import 'routerule.dart';

 const k_vminstanc='_vminstanc';
 const k_sourcemsg='_sourcemsg';
 const k_localstat='_localstat';

 class condBrokerBag
 {
    VMrouter vminstanc;
    IDkey sourcemsg;
    Map<String,dynamic> localstat;
 }

 class condBroker extends Object with ExpandoMe
 {
   dynamic get_local_stat(String key)
   {
     Map<String,dynamic> stat=this[k_localstat];
     return stat[key];
   }

   dynamic get_msg_value(String path)
   {
     Map<String,dynamic> msg=this[k_sourcemsg];
   }
 }