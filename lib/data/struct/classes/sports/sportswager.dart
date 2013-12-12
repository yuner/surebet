library SportsWager;

import '../../../base.dart';

const k_SportsWagerID='SportsWagerID';
const k_SportsMarketID='SportsMarketID';
const k_WagerGroupKey='WagerGroupKey';
const k_WagerTypeKey='WagerTypeKey';
const k_Odds='Odds';

class SportsWager
{
  IDkey SportsWagerID;
  IDkey SportsMarketID;
  IDkey WagerGroupKey;
  IDkey WagerTypeKey;
  num Odds;


  Map<String,dynamic> toMap()
  {


    return {k_SportsWagerID:SportsMarketID
            ,k_SportsMarketID:SportsMarketID
            ,k_WagerGroupKey:WagerGroupKey
            ,k_WagerTypeKey:WagerTypeKey
            ,k_Odds:Odds};
  }

  static SportsWager fromMap(Map<String,dynamic> map)
  {
    return new SportsWager()
                ..SportsWagerID=map[k_SportsWagerID]
                ..SportsMarketID=map[k_SportsMarketID]
                ..WagerGroupKey=map[k_WagerGroupKey]
                ..WagerTypeKey=map[k_WagerTypeKey]
                ..Odds=map[k_Odds];
  }

}