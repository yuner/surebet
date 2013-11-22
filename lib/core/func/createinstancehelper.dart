library ClassCreateHelper;

import 'dart:mirrors';

dynamic CreateInstance(Symbol libraryname,Symbol classname,List arguments)
{
  MirrorSystem curmirror = currentMirrorSystem();
  try
  {
    LibraryMirror libmirror = curmirror.findLibrary(libraryname);
    ClassMirror clsmirror = libmirror.declarations[classname];
    InstanceMirror insmirror = clsmirror.newInstance(const Symbol(''),arguments);
    return insmirror.reflectee;
  }
  catch (e)
  {
    return null;
  }
}

dynamic CreateInstancebyString(String libraryname,String classname,List arguments,[String constname=''])
{
  MirrorSystem curmirror = currentMirrorSystem();
  try
  {
    LibraryMirror libmirror = curmirror.findLibrary(new Symbol(libraryname));
    ClassMirror clsmirror = libmirror.declarations[MirrorSystem.getSymbol(classname, libmirror)];
    InstanceMirror insmirror = clsmirror.newInstance(MirrorSystem.getSymbol(constname, libmirror),arguments);
    return insmirror.reflectee;
  }
  catch (e)
  {
    return null;
  }
}
