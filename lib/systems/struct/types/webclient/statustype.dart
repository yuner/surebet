library statusType;

 const waiting='waiting';
 const loginning='loginning';
 const focusing='focusing';
 const focused='focused';
 const retrieving='retrieving';

 class statusType
 {

   static const _waiting=const statusType._(waiting);
   static const _loginning=const statusType._(loginning);
   static const _focusing=const statusType._(focusing);
   static const _focused=const statusType._(focused);
   static const _retrieving=const statusType._(retrieving);

   static final Map _keylist={
                              waiting:_waiting,
                              loginning:_loginning,
                              focusing:_focusing,
                              focused:_focused,
                              retrieving:_retrieving
   };

   final String _key;
   String get typeid=>_key;

   static types(String key)=>_keylist[key];

   const statusType._(this._key);

   //operator==(statusType obj)=>_key==obj._key;

 }