library statusType;

 const free='free';
 const waiting='waiting';
 const loginning='loginning';
 const focusing='focusing';
 const focused='focused';
 const retrieving='retrieving';
 const locked='locked';

 class statusType
 {
   static const c_free=const statusType._(free);
   static const c_waiting=const statusType._(waiting);
   static const c_loginning=const statusType._(loginning);
   static const c_focusing=const statusType._(focusing);
   static const c_focused=const statusType._(focused);
   static const c_retrieving=const statusType._(retrieving);
   static const c_locked=const statusType._(locked);

   static final Map _keylist={
                              free:c_free,
                              waiting:c_waiting,
                              loginning:c_loginning,
                              focusing:c_focusing,
                              focused:c_focused,
                              retrieving:c_retrieving,
                              locked:c_locked
   };

   final String _key;
   String get typeid=>_key;

   static types(String key)=>_keylist[key];

   const statusType._(this._key);

   //operator==(statusType obj)=>_key==obj._key;

 }