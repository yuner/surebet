

part of sbo;

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

class login
{
  static const userName='userName';
  static const passWord='passWord';
}

class loginResult
{
  static const succeed='succeed';
}

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