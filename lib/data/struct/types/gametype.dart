library GameTypes;

import '../../base.dart';

 const Sports='Sports';
 const Casinos='Casinos';
 const LiveCasinos='LiveCasinos';
 const Pokers='Pokers';
 const Games='Games';
 const Races='Races';

 class GameTypes
 {
   static const _Sports=const GameTypes._(Sports);
   static const _Casinos=const GameTypes._(Casinos);
   static const _LiveCasinos=const GameTypes._(LiveCasinos);
   static const _Pokers=const GameTypes._(Pokers);
   static const _Games=const GameTypes._(Games);
   static const _Races=const GameTypes._(Races);

   static final Map<IDkey,GameTypes> _keylist={
                              Sports:_Sports,
                              Casinos:_Casinos,
                              LiveCasinos:_LiveCasinos,
                              Pokers:_Pokers,
                              Games:_Games,
                              Races:_Races
   };

   final IDkey _key;
   IDkey get typeid=>_key;

   static types(IDkey key)=>_keylist[key];

   const GameTypes._(this._key);

   //operator==(GameTypes obj)=>_key==obj._key;
 }