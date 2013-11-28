

part of sbo;

// move to web_client_messages.dart
/*
class SBO
{
  static const login='login';
  static const logout='logout';
  static const keepalive='keepalive';
  static const focus='focus';
  static const bet='bet';
  static const getodds='getodds';

  static const loginResult='loginResult';
  static const logoutResult='logoutResult';
  static const keepaliveResult='keepaliveResult';
  static const focusResult='focusResult';
  static const betResult='betResult';
  static const getoddsResult='getoddsResult';
}
*/

// move to struct/message/webclient/login.dart
/*
class login
{
  static const userName='userName';
  static const passWord='passWord';
}
*/

// move to struct/message/webclient/loginresult.dart
/*
class loginResult
{
  static const succeed='succeed';
}
*/

// move to struct/types/webclient/statusupdated.dart
/*
class statusUpdated
{
  static const waiting='waiting';
  static const loginning='loginning';
  static const focusing='focusing';
  static const focused='focused';
  static const retrieving='retrieving';

}
*/

class sboWebclient extends WebclientBase
{

  sboWebclient()
  {

    registerMsg(W_MSG.login, login);
    registerMsg(W_MSG.getodds, getodds);
    registerMsg(W_MSG.keepalive, keepalive);
    registerMsg(W_MSG.focus, focus);
    registerMsg(W_MSG.bet, bet);
    registerMsg(W_MSG.getodds, getodds);

    statusNow=T_Status.statusType.types(T_Status.waiting);

  }

  void login(Map<String,dynamic> msg)
  {
    var user=msg[M_Login.userName];
    var pass=msg[M_Login.passWord];


    var newmsg={MSG.k_msgid:W_MSG.loginResult
                ,M_LoginResult.succeedType:T_Succeed.loginOK};
    postMsg(newmsg);
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