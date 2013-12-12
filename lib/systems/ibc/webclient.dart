

part of ibc;


class ibcWebclient extends WebclientBase
{

  ibcWebclient([HttpClient client=null]):super(client)
  {
    sysType=TS.SystemTypes.c_Ibc;

    httpClient.userAgent='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36';
    httpClient.badCertificateCallback=(x509, host, port)=>true;

    registerMsg(W_MSG.login, login);
    registerMsg(W_MSG.getodds, getodds);
    registerMsg(W_MSG.keepalive, keepalive);
    registerMsg(W_MSG.focus, focus);
    registerMsg(W_MSG.bet, bet);
    registerMsg(W_MSG.getodds, getodds);

    statusNow=T_Status.statusType.c_free;

  }

  void login(Map<String,dynamic> msg)
  {

    switch(statusNow)
    {
      case T_Status.statusType.c_free:
      //case T_Status.statusType.c_waiting:
      //case T_Status.statusType.c_focused:
        // start login
        statusNow=T_Status.statusType.c_loginning;

        userName=msg[M_Login.userName];
        passWord=msg[M_Login.passWord];
        baseURL=msg[M_Login.baseURL];

        httpClient.getUrl(Uri.parse(baseURL))
          ..catchError((onError){

              statusNow=T_Status.statusType.c_free;
              var newmsg={MSG.k_msgid:W_MSG.loginResult
                          ,M_LoginResult.ResultType:T_Result.Failed};
              postMsg(newmsg);

            }, test:(errObject){

              return true;
            })
          ..whenComplete((){



            var newmsg={MSG.k_msgid:W_MSG.loginResult
                        ,M_LoginResult.ResultType:T_Result.Succeed};
            postMsg(newmsg);
          });
        break;

      case T_Status.statusType.c_locked:
        // post a message to indicate account locked
        break;
      default:
        // post a message to indicate unsupported
        break;
    }
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