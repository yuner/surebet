library SportsEvent;

import '../../types/sports/sportstype.dart' as ST;
import '../../types/sports/markettype.dart' as MT;
import 'sportsmarket.dart' as SM;

   const SportsEventID='SportsEventID';
   const SportType='SportsType';
   const LeagueID='LeagueID';
   const HostTeamID='HostTeamID';
   const GuestTeamID='GuestTeamID';
   const MarketCollection='MarketCollection';

   class SportsEvent
   {
     String SportsEventID;
     ST.SportTypes SportType;
     String LeagueID;
     String HostTeamID;
     String GuestTeamID;
     Map<MT.MarketTypes,List<SM.SportsMarket>> MarketCollection;
   }