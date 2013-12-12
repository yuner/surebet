library Error;

import '../../base.dart';

  const Key='errKey';             //String:IDkey
  const Description='errString';  //String
  const ExpObject='errMap';          //Map<String:dynamic>

 class Error
 {
   IDkey Key;
   String Description;
   Exception ExpObject;
 }