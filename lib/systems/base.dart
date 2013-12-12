library sysbase;

import 'dart:io';

import '../core/vm.dart';
//import '../data/base.dart';

import '../core/struct/message.dart' as MSG;

import '../data/struct/classes/sports/sportsevent.dart' as SE;
import '../data/struct/classes/sports/sportsleague.dart' as SL;
import '../data/struct/classes/sports/sportsteam.dart' as ST;
//import '../data/struct/classes/sports/sportsmarket.dart' as SM;
//import '../data/struct/classes/sports/sportswager.dart' as SW;

import '../data/struct/types/systemtype.dart' as TS;

import 'struct/sysmsg/naming_messages.dart' as N_MSG;
import 'struct/sysmsg/naming/replacetoid.dart' as M_ReplaceToID;
import 'struct/sysmsg/naming/idreplaced.dart' as M_IDReplaced;
import 'struct/sysmsg/naming/updatenames.dart' as M_updateNames;
import 'struct/sysmsg/naming/leagueupdated.dart' as M_leagueUpdated;
import 'struct/sysmsg/naming/teamupdated.dart' as M_teamUpdated;

//import 'struct/sysmsg/webclient_messages.dart' as W_MSG;
//import 'struct/sysmsg/webclient/login.dart' as M_Login;
//import 'struct/sysmsg/webclient/loginresult.dart' as M_LoginResult;

import 'struct/types/webclient/statustype.dart' as T_Status;
//import 'struct/types/webclient/succeedtype.dart' as T_Succeed;

part 'controllerbase.dart';
part 'namingbase.dart';
part 'parserbase.dart';
part 'webclientbase.dart';