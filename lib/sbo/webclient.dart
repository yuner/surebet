

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

class sboWebclient extends VMbase
{
  sboWebclient.SBOwebclient()
  {
    registerMsg(SBO.login, login);
    registerMsg(SBO.getodds, getodds);
    registerMsg(SBO.keepalive, keepalive);
    registerMsg(SBO.focus, focus);
    registerMsg(SBO.bet, bet);
    registerMsg(SBO.getodds, getodds);
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