library succeedType;

const loginOK='loginOK';
const loginFailed='loginFailed';
const alreadyLogined='alreadyLogined';

class succeedType
{

  static const _loginOK=const succeedType._(loginOK);
  static const _loginFailed=const succeedType._(loginFailed);
  static const _alreadyLogined=const succeedType._(alreadyLogined);


  static final Map _keylist={
                             loginOK:_loginOK,
                             loginFailed:_loginFailed,
                             alreadyLogined:_alreadyLogined
  };

  final String _key;
  String get typeid=>_key;

  static types(String key)=>_keylist[key];

  const succeedType._(this._key);

  //operator==(succeedType obj)=>_key==obj._key;

}