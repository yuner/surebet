library NestObjectHelper;

import 'dart:mirrors';

GetNestObjectByString(dynamic obj,String path)
{
  if (path==null||obj==null) return null;
  var pathlist=path.split('.');
  return GetNestObjectByList(obj,pathlist);
}

GetNestObjectByList(dynamic obj,List<String> pathlist)
{
  if (pathlist==null||obj==null) return null;

  if (pathlist.length>1)
  {
    var newobj=GetObjectField(obj,pathlist[0]);
    if (newobj!=null)
      return GetNestObjectByList(newobj,pathlist);
  }
  else if (pathlist.length>0)
  {
    return GetObjectField(obj,pathlist[0]);
  }
  return null;
}

GetObjectField(dynamic obj,String key)
{
  var refobj=reflect(obj);
  if (refobj.getField(const Symbol('[]'))!=null)
    return obj[key];
  else
  {
    var refval=refobj.getField(new Symbol(key));
    if (refval!=null)
      return refval.reflectee;
  }
  return null;
}

void SetNestObjectByString(dynamic obj,String path,value)
{
  if (path==null||obj==null) return null;
  var pathlist=path.split('.');
  SetNestObjectByList(obj,pathlist,value);
}

void SetNestObjectByList(dynamic obj,List<String> pathlist,value)
{
  if (pathlist==null||obj==null) return null;

  if (pathlist.length>1)
  {
    var newobj=GetObjectField(obj,pathlist[0]);
    newobj=(newobj==null)?{}:newobj;
    SetNestObjectByList(newobj,pathlist,value);
  }
  else if (pathlist.length>0)
  {
    SetObjectField(obj,pathlist[0],value);
  }
}

SetObjectField(dynamic obj,String key,value)
{
  var refobj=reflect(obj);
  if (refobj.getField(const Symbol('[]='))!=null)
    obj[key]=value;
  else
    var refval=refobj.setField(new Symbol(key), value);
}