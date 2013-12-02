library execresult;

//import '../../vm.dart';
import '../../../data/base.dart';

import 'routerule.dart';

 const k_sourcemsg='_sourcemsg';
 const k_localstat='_localstat';

 class execResultBag
 {
    IDkey sourcemsg;
    Map<String,dynamic> localstat;
 }

 class execResult extends Object with ExpandoMe
 {
   Map<String,dynamic> updateStats(Map<String,dynamic> localStats)
   {
     return this[k_localstat];
   }
 }