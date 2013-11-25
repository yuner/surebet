

/**
 * SBO<->webclient<->parser<->naming<->controller
 *          ^-----------------------------^
 */

library sbo;

import 'dart:core';
//import 'dart:io';

import '../core/vm.dart';
//import '../data/base.dart';

import '../core/struct/message.dart' as MSG;
import 'webclient_messages.dart' as SBO;
import 'struct/message/webclient/login.dart' as M_Login;
import 'struct/message/webclient/loginresult.dart' as M_LoginResult;
import 'struct/types/webclient/statustype.dart' as T_Status;

part 'webclient.dart';
part 'parser.dart';
part 'controller.dart';
part 'naming.dart';

