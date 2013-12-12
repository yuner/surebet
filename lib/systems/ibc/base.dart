

/**
 * IBC<->webclient<->parser<->naming<->controller
 *          ^-----------------------------^
 */

library ibc;

import 'dart:core';
import 'dart:io';

import '../../core/vm.dart';
import '../base.dart';

//import '../data/base.dart';

//import '../../data/struct/classes/sports/sportsevent.dart' as SE;
//import '../../data/struct/classes/sports/sportsleague.dart' as SL;
//import '../../data/struct/classes/sports/sportsteam.dart' as ST;

import '../../data/struct/types/systemtype.dart' as TS;

import '../../core/struct/message.dart' as MSG;
import '../struct/sysmsg/webclient_messages.dart' as W_MSG;
import '../struct/sysmsg/naming_messages.dart' as N_MSG;
//import '../sysmsg/naming/replacetoid.dart' as M_ReplaceToID;
import '../struct/sysmsg/webclient/login.dart' as M_Login;
import '../struct/sysmsg/webclient/loginresult.dart' as M_LoginResult;

import '../struct/types/webclient/statustype.dart' as T_Status;
import '../struct/types/webclient/resulttype.dart' as T_Result;

part 'webclient.dart';
part 'parser.dart';
part 'controller.dart';
part 'naming.dart';

