library resultType;

const Succeed='Succeed';
const Failed='Failed';

class resultType
{

  static const c_Succeed=const resultType._(Succeed);
  static const c_Failed=const resultType._(Failed);

  static final Map _keylist={
                             Succeed:c_Succeed,
                             Failed:c_Failed,
  };

  final String _key;
  String get typeid=>_key;

  static types(String key)=>_keylist[key];

  const resultType._(this._key);

  //operator==(succeedType obj)=>_key==obj._key;

}