
part of ydata;

class IDkey=String with IDbase,keyBase;

abstract class IDinterface
{
  num get uid;
}

abstract class keyInterface
{
  String get uid;
}

abstract class IDbase implements IDinterface
{
  num _id;
  bool _hasid;
  num get uid=>_hasid?_id:_genid(this);
  static num _genid(IDbase id)
  {
    //id._id=identityHashCode(id);

    id._hasid=true;
  }
}

abstract class keyBase implements keyInterface
{
  String _key;
  bool _haskey;
  String get uid=>_haskey?_key:_genkey(this);
  static String _genkey(keyBase key)
  {
    //key._key=identityHashCode(key).toDouble();
    key._haskey=true;
  }
}