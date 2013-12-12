part of sysbase;

abstract class WebclientBase extends VMbase
{

  HttpClient httpClient;
  TS.SystemTypes sysType;

  T_Status.statusType _statusNow=null;
  T_Status.statusType get statusNow=>_statusNow;

  String userName;
  String passWord;
  String baseURL;

  WebclientBase([HttpClient client])
                :httpClient = (client!=null)?client:new HttpClient()
  {

  }

  void set statusNow(T_Status.statusType status)
  {
    if (status!=_statusNow && _statusNow!=null)
    {
      // post a message to indicated status changed
    }
    _statusNow=status;
  }


  void login(Map<String,dynamic> msg);
  void logout(Map<String,dynamic> msg);
  void keepalive(Map<String,dynamic> msg);
  void focus(Map<String,dynamic> msg);
  void bet(Map<String,dynamic> msg);
  void getodds(Map<String,dynamic> msg);


}