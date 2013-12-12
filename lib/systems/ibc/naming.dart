
part of ibc;

class aaa=int;

class ibcNameWrapper extends NameWrapperBase
{

  ibcNameWrapper()
  {
    registerMsg(N_MSG.replaceToID, replaceToID);
    registerMsg(N_MSG.updateNames, updateNames);
  }

}

