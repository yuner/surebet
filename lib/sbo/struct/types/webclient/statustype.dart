library statusType;

 const waiting='waiting';
 const loginning='loginning';
 const focusing='focusing';
 const focused='focused';
 const retrieving='retrieving';

 class statusType
 {

   static const kwaiting=const statusType._(waiting);
   static const kloginning=const statusType._(loginning);
   static const kfocusing=const statusType._(focusing);
   static const kfocused=const statusType._(focused);
   static const kretrieving=const statusType._(retrieving);

   static final Map _keylist={
                              waiting:kwaiting,
                              loginning:kloginning,
                              focusing:kfocusing,
                              focused:kfocused,
                              retrieving:kretrieving
   };

   final String _key;
   String get key=>_key;

   static instance(String key)=>_keylist[key];

   const statusType._(this._key);

   //operator==(statusType obj)=>_key==obj._key;

 }