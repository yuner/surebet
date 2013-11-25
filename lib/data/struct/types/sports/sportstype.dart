library SportTypes;

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
   static const kFootball=const SportTypes._(Football);
   static const kBasketball=const SportTypes._(Basketball);
   static const kBaseball=const SportTypes._(Baseball);
   static const kTennis=const SportTypes._(Tennis);
   static const kAmericanFootball=const SportTypes._(AmericanFootball);
   static const kAthletics=const SportTypes._(Athletics);
   static const kBadminton=const SportTypes._(Badminton);
   static const kBeachSoccer=const SportTypes._(BeachSoccer);
   static const kBoxing=const SportTypes._(Boxing);
   static const kCricket=const SportTypes._(Cricket);
   static const kCycling=const SportTypes._(Cycling);
   static const kDarts=const SportTypes._(Darts);
   static const kEntertainment=const SportTypes._(Entertainment);
   static const kFieldHockey=const SportTypes._(FieldHockey);
   static const kFinancial=const SportTypes._(Financial);
   static const kFutsal=const SportTypes._(Futsal);
   static const kGolf=const SportTypes._(Golf);
   static const kHandball=const SportTypes._(Handball);
   static const kIceHockey=const SportTypes._(IceHockey);
   static const kLacrosse=const SportTypes._(Lacrosse);
   static const kMixedMartialArts=const SportTypes._(MixedMartialArts);
   static const kMotorSport=const SportTypes._(MotorSport);
   static const kOlympic=const SportTypes._(Olympic);
   static const kPool_Snooker=const SportTypes._(Pool_Snooker);
   static const kRugby=const SportTypes._(Rugby);
   static const kSquash=const SportTypes._(Squash);
   static const kTableTennis=const SportTypes._(TableTennis);
   static const kVolleyball=const SportTypes._(Volleyball);
   static const kWaterPolo=const SportTypes._(WaterPolo);
   static const kWinterSports=const SportTypes._(WinterSports);

   static final Map _keylist={
                              Football:kFootball,
                              Basketball:kBasketball,
                              Baseball:kBaseball,
                              Tennis:kTennis,
                              AmericanFootball:kAmericanFootball,
                              Athletics:kAthletics,
                              Badminton:kBadminton,
                              BeachSoccer:kBeachSoccer,
                              Boxing:kBoxing,
                              Cricket:kCricket,
                              Cycling:kCycling,
                              Darts:kDarts,
                              Entertainment:kEntertainment,
                              FieldHockey:kFieldHockey,
                              Financial:kFinancial,
                              Futsal:kFutsal,
                              Golf:kGolf,
                              Handball:kHandball,
                              IceHockey:kIceHockey,
                              Lacrosse:kLacrosse,
                              MixedMartialArts:kMixedMartialArts,
                              MotorSport:kMotorSport,
                              Olympic:kOlympic,
                              Pool_Snooker:kPool_Snooker,
                              Rugby:kRugby,
                              Squash:kSquash,
                              TableTennis:kTableTennis,
                              Volleyball:kVolleyball,
                              WaterPolo:kWaterPolo,
                              WinterSports:kWinterSports
   };


   final String _key;
   String get key=>_key;

   static instance(String key)=>_keylist[key];

   const SportTypes._(this._key);

   //operator==(SportTypes obj)=>_key==obj._key;
 }