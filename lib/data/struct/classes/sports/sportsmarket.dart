library SportsMarket;

import '../../../base.dart';

import 'sportswager.dart' as SW;
import '../../types/sports/markettype.dart' as MT;

const k_SportsMarketID='SportsMarketID';
const k_SportsEventID='SportsEventID';
const k_MarketType='MarketType';
const k_WagerCollection='WagerCollection';

class SportsMarket
{
  IDkey SportsMarketID;
  IDkey SportsEventID;
  MT.MarketTypes MarketType;
  Map<IDkey,List<SW.SportsWager>> WagerCollection;

  Map<String,dynamic> toMap()
  {

    var mc=new Map<String,dynamic>();

    WagerCollection.forEach((K,V)
    {
      var lis=new List<Map<String,dynamic>>();
      V.forEach((E){
        lis.add(E.toMap());
      });
      mc[K]=lis;
    });

    return {k_SportsMarketID:SportsMarketID
            ,k_SportsEventID:SportsEventID
            ,k_MarketType:MarketType.typeid
            ,k_WagerCollection:mc};
  }

  static SportsMarket fromMap(Map<String,dynamic> map)
  {
    var nmc=new Map<IDkey,List<SW.SportsWager>>();

    Map<String,List<Map<String,dynamic>>> mc=map[k_WagerCollection];
    mc.forEach((K,V)
    {
      var key=K;
      var value=new List<SW.SportsWager>();
      V.forEach((E){
        value.add(SW.SportsWager.fromMap(E));
      });
      nmc[K]=V;
    });


    return new SportsMarket()
    ..SportsMarketID=map[k_SportsMarketID]
    ..SportsEventID=map[k_SportsEventID]
    ..MarketType=MT.MarketTypes.types(map[k_MarketType])
    ..WagerCollection=nmc;
  }

}



