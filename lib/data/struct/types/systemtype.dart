library SystemTypes;

import '../../base.dart';

 const Sbo='Sbo';
 const Ibc='Ibc';
 const Pinnacle='Pinnacle';
 const Crown='Crown';

 class SystemTypes
 {
   static const c_Sbo=const SystemTypes._(Sbo);
   static const c_Ibc=const SystemTypes._(Ibc);
   static const c_Pinnacle=const SystemTypes._(Pinnacle);
   static const c_Crown=const SystemTypes._(Crown);

   static final Map<IDkey,SystemTypes> _keylist={
                              Sbo:c_Sbo,
                              Ibc:c_Ibc,
                              Pinnacle:c_Pinnacle,
                              Crown:c_Crown
   };

   final IDkey _key;
   IDkey get typeid=>_key;

   static types(IDkey key)=>_keylist[key];

   const SystemTypes._(this._key);

   //operator==(SystemTypes obj)=>_key==obj._key;

 }