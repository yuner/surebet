library SportTypes;

import '../../../base.dart';

 const Football='Football';
 const Basketball='Basketball';
 const Baseball='Baseball';
 const Tennis='Tennis';
 const AmericanFootball='AmericanFootball';
 const Athletics='Athletics';
 const Badminton='Badminton';
 const BeachSoccer='BeachSoccer';
 const Boxing='Boxing';
 const Cricket='Cricket';
 const Cycling='Cycling';
 const Darts='Darts';
 const Entertainment='Entertainment';
 const FieldHockey='FieldHockey';
 const Financial='Financial';
 const Futsal='Futsal';
 const Golf='Golf';
 const Handball='Handball';
 const IceHockey='IceHockey';
 const Lacrosse='Lacrosse';
 const MixedMartialArts='MixedMartialArts';
 const MotorSport='MotorSport';
 const Olympic='Olympic';
 const Pool_Snooker='Pool_Snooker';
 const Rugby='Rugby';
 const Squash='Squash';
 const TableTennis='TableTennis';
 const Volleyball='Volleyball';
 const WaterPolo='WaterPolo';
 const WinterSports='WinterSports';

 class SportTypes
 {
   static const _Football=const SportTypes._(Football);
   static const _Basketball=const SportTypes._(Basketball);
   static const _Baseball=const SportTypes._(Baseball);
   static const _Tennis=const SportTypes._(Tennis);
   static const _AmericanFootball=const SportTypes._(AmericanFootball);
   static const _Athletics=const SportTypes._(Athletics);
   static const _Badminton=const SportTypes._(Badminton);
   static const _BeachSoccer=const SportTypes._(BeachSoccer);
   static const _Boxing=const SportTypes._(Boxing);
   static const _Cricket=const SportTypes._(Cricket);
   static const _Cycling=const SportTypes._(Cycling);
   static const _Darts=const SportTypes._(Darts);
   static const _Entertainment=const SportTypes._(Entertainment);
   static const _FieldHockey=const SportTypes._(FieldHockey);
   static const _Financial=const SportTypes._(Financial);
   static const _Futsal=const SportTypes._(Futsal);
   static const _Golf=const SportTypes._(Golf);
   static const _Handball=const SportTypes._(Handball);
   static const _IceHockey=const SportTypes._(IceHockey);
   static const _Lacrosse=const SportTypes._(Lacrosse);
   static const _MixedMartialArts=const SportTypes._(MixedMartialArts);
   static const _MotorSport=const SportTypes._(MotorSport);
   static const _Olympic=const SportTypes._(Olympic);
   static const _Pool_Snooker=const SportTypes._(Pool_Snooker);
   static const _Rugby=const SportTypes._(Rugby);
   static const _Squash=const SportTypes._(Squash);
   static const _TableTennis=const SportTypes._(TableTennis);
   static const _Volleyball=const SportTypes._(Volleyball);
   static const _WaterPolo=const SportTypes._(WaterPolo);
   static const _WinterSports=const SportTypes._(WinterSports);

   static final Map<IDkey,SportTypes> _keylist={
                              Football:_Football,
                              Basketball:_Basketball,
                              Baseball:_Baseball,
                              Tennis:_Tennis,
                              AmericanFootball:_AmericanFootball,
                              Athletics:_Athletics,
                              Badminton:_Badminton,
                              BeachSoccer:_BeachSoccer,
                              Boxing:_Boxing,
                              Cricket:_Cricket,
                              Cycling:_Cycling,
                              Darts:_Darts,
                              Entertainment:_Entertainment,
                              FieldHockey:_FieldHockey,
                              Financial:_Financial,
                              Futsal:_Futsal,
                              Golf:_Golf,
                              Handball:_Handball,
                              IceHockey:_IceHockey,
                              Lacrosse:_Lacrosse,
                              MixedMartialArts:_MixedMartialArts,
                              MotorSport:_MotorSport,
                              Olympic:_Olympic,
                              Pool_Snooker:_Pool_Snooker,
                              Rugby:_Rugby,
                              Squash:_Squash,
                              TableTennis:_TableTennis,
                              Volleyball:_Volleyball,
                              WaterPolo:_WaterPolo,
                              WinterSports:_WinterSports
   };


   final IDkey _key;
   IDkey get typeid=>_key;

   static types(IDkey key)=>_keylist[key];

   const SportTypes._(this._key);

   //operator==(SportTypes obj)=>_key==obj._key;
 }