library SystemTypes;

 const Sbo='Sbo';
 const Ibc='Ibc';
 const Pinnacle='Pinnacle';
 const Crown='Crown';

 class SystemTypes
 {
   static const _Sbo=const SystemTypes._(Sbo);
   static const _Ibc=const SystemTypes._(Ibc);
   static const _Pinnacle=const SystemTypes._(Pinnacle);
   static const _Crown=const SystemTypes._(Crown);

   static final Map _keylist={
                              Sbo:_Sbo,
                              Ibc:_Ibc,
                              Pinnacle:_Pinnacle,
                              Crown:_Crown
   };

   final String _key;
   String get typeid=>_key;

   static types(String key)=>_keylist[key];

   const SystemTypes._(this._key);

   //operator==(SystemTypes obj)=>_key==obj._key;

 }