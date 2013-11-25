library SportsMarket;

import 'sportswager.dart';
import '../../types/sports/markettype.dart' as MT;

const SportsMarketID='SportsMarketID';
const SportsEventID='SportsEventID';
const MarketType='MarketType';
const WagerCollection='WagerCollection';

class SportsMarket
{
  String SportsMarketID;
  String SportsEventID;
  MT.MarketTypes MarketType;
  Map<String,List<SportsWager>> WagerCollection;
}

