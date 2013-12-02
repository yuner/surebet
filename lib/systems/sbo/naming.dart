
part of sbo;

class aaa=int;

class sboNameWrapper extends NameWrapperBase
{

  sboNameWrapper()
  {
    registerMsg(N_MSG.replaceToID, replaceToID);
    registerMsg(N_MSG.updateNames, updateNames);
  }

}

