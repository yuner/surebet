part of sysbase;

abstract class WebclientBase extends VMbase
{

  T_Status.statusType _statusNow;
  T_Status.statusType get statusNow=>_statusNow;
  void set statusNow(T_Status.statusType status)
  {
    // post a message to indicated status changed
    _statusNow=status;
  }


  void login(Map<String,dynamic> msg)
  {

  }

  void logout(Map<String,dynamic> msg)
  {

  }
  void keepalive(Map<String,dynamic> msg)
  {

  }
  void focus(Map<String,dynamic> msg)
  {

  }
  void bet(Map<String,dynamic> msg)
  {

  }
  void getodds(Map<String,dynamic> msg)
  {

  }

}