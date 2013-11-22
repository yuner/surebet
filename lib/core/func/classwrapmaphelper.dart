library ClassWrapHelper;

import 'dart:mirrors';

const simpleName='#simpleName#';
const qualifiedName='#qualifiedName#';
const libraryName='#libraryName#';

dynamic ClassToMap(obj)
{
  if (obj==null) return obj;
  if (obj is String || obj is num) return obj;
  var robj=reflect(obj);
  var type=robj.type;
  var decs=type.declarations;
  var map={simpleName:MirrorSystem.getName(type.simpleName)
       ,qualifiedName:MirrorSystem.getName(type.qualifiedName)
       ,libraryName:MirrorSystem.getName(type.owner.simpleName)};
  for (var key in decs.keys)
  {
    var mirs=decs[key];
    if (mirs is VariableMirror)
      map[MirrorSystem.getName(key)]=ClassToMap(robj.getField(key).reflectee);
  }
  return map;
}

MapToClass(Map<String,dynamic>map)
{
  if (map==null) return map;
  var _simpleName=map[simpleName];
  var _qualifiedName=map[qualifiedName];
  var _libraryName=map[libraryName];
  if (_simpleName==null||_qualifiedName==null) return map;
  var libsym=currentMirrorSystem().findLibrary(new Symbol(_libraryName));
  var clssym=MirrorSystem.getSymbol(_simpleName, libsym);
  var clsmir=libsym.declarations[clssym];
  var clsins=(clsmir as ClassMirror).newInstance(const Symbol(''), [], null);
  var obj=clsins.reflectee;
  for (String prop in map.keys)
  {
    if (prop==simpleName || prop==qualifiedName)
      continue;
    var val=map[prop];
    var robj=reflect(obj);
    if (val is Map<String,dynamic>)
      robj.setField(MirrorSystem.getSymbol(prop, libsym), MapToClass(val));
    else
      robj.setField(MirrorSystem.getSymbol(prop, libsym), obj);
  }
  return obj;
}