library GameTypes;
 const Sports='Sports';
 const Casinos='Casinos';
 const LiveCasinos='LiveCasinos';
 const Pokers='Pokers';
 const Games='Games';
 const Races='Races';

 class GameTypes
 {
   static const kSports=const GameTypes._(Sports);
   static const kCasinos=const GameTypes._(Casinos);
   static const kLiveCasinos=const GameTypes._(LiveCasinos);
   static const kPokers=const GameTypes._(Pokers);
   static const kGames=const GameTypes._(Games);
   static const kRaces=const GameTypes._(Races);

   static final Map _keylist={
                              Sports:kSports,
                              Casinos:kCasinos,
                              LiveCasinos:kLiveCasinos,
                              Pokers:kPokers,
                              Games:kGames,
                              Races:kRaces
   };

   final String _key;
   String get key=>_key;

   static instance(String key)=>_keylist[key];

   const GameTypes._(this._key);

   //operator==(GameTypes obj)=>_key==obj._key;
 }