library SystemTypes;

 const Sbo='Sbo';
 const Ibc='Ibc';
 const Pinnacle='Pinnacle';
 const Crown='Crown';

 class SystemTypes
 {
   static const kSbo=const SystemTypes._(Sbo);
   static const kIbc=const SystemTypes._(Ibc);
   static const kPinnacle=const SystemTypes._(Pinnacle);
   static const kCrown=const SystemTypes._(Crown);

   static final Map _keylist={
                              Sbo:kSbo,
                              Ibc:kIbc,
                              Pinnacle:kPinnacle,
                              Crown:kCrown
   };

   final String _key;
   String get key=>_key;

   static instance(String key)=>_keylist[key];

   const SystemTypes._(this._key);

   //operator==(SystemTypes obj)=>_key==obj._key;

 }