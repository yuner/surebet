library routerule;

//import '../../vm.dart';
//import '../../../data/base.dart';

 const k_rtcondition='_rtcondition';
 const k_rtexecution='_rtexecution';
 const k_rtsourcekey='_rtsourcekey';
 const owner='#owner#';
 const report='#report#';

 class routerulePack
 {
   Function rtcondition;
   Function rtexecution;
   RegExp rtsourcekey;

   Map<String,dynamic> toMap()
   {
     return {k_rtcondition:rtcondition
       ,k_rtexecution:rtexecution
       ,k_rtsourcekey:rtsourcekey.pattern};
   }
 }

 class ExpandoMe<Tkey, Tval>
 {
   Map<Tkey,Tval> _localMap={};
   Tval operator[](Tkey key)=>_localMap[key];
   void operator[]=(Tkey key,Tval val){_localMap[key]=val;}
 }