library SportsMarket;

import '../../../base.dart';

import 'sportswager.dart';
import '../../types/sports/markettype.dart' as MT;

const SportsMarketID='SportsMarketID';
const SportsEventID='SportsEventID';
const MarketType='MarketType';
const WagerCollection='WagerCollection';

class SportsMarket
{
  IDkey SportsMarketID;
  IDkey SportsEventID;
  MT.MarketTypes MarketType;
  Map<IDkey,List<SportsWager>> WagerCollection;
}

