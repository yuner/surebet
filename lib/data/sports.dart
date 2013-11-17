
part of ysystem;

class SportsEvent
{
  static const SportsEventID='SportsEventID';
  static const SportType='SportsType';
  static const LeagueID='LeagueID';
  static const HostTeamID='HostTeamID';
  static const GuestTeamID='GuestTeamID';
  static const MarketCollection='MarketCollection';
}

class SportsMarket
{
  static const SportsMarketID='SportsMarketID';
  static const SportsEventID='SportsEventID';
  static const MarketType='MarketType';
  static const WagerCollection='WagerCollection';
}

class SportsWager
{
  static const SportsWagerID='SportsWagerID';
  static const SportsMarketID='SportsMarketID';
  static const WagerGroupKey='WagerGroupKey';
  static const WagerTypeKey='WagerTypeKey';
  static const Odds='Odds';
}

class SportsLeague
{
  static const SportsLeagueID='SportsLeagueID';
  static const LeagueDisplayName='LeagueDisplayName';
  static const LeagueAliasNames='LeagueAliasNames';
  static const NameFilterRegExp='NameFilterRegExp';
}

class SportsTeam
{
  static const SportsTeamID='SportsLeagueID';
  static const TeamDisplayName='TeamDisplayName';
  static const TeamAliasNames='TeamAliasNames';
  static const NameFilterRegExp='NameFilterRegExp';
}

class SportsAliasNames
{
  static const SystemType='SystemType';
  static const NamesList='NamesList';
}

class SystemTypes
{
  static const Sbo='Sbo';
  static const Ibc='Ibc';
  static const Pinnacle='Pinnacle';
  static const Crown='Crown';
}

//will be stored in db, class is no need anymore
class MarketTypes
{
  static const Asian_Handicap='Asian_Handicap';
  static const Odd_Even='Odd_Even';
  static const Over_Under='Over_Under';
  static const Correct_Score='Correct_Score';
  static const OneXTwo='OneXTwo';
  static const Total_Goal='Total_Goal';
  static const First_Half_Asian_Handicap='First_Half_Asian_Handicap';
  static const First_Half_1X2='First_Half_1X2';
  static const First_Half_Over_Under='First_Half_Over_Under';
  static const Half_Time_Full_Time='Half_Time_Full_Time';
  static const Money_Line='Money_Line';
  static const First_Half_Odd_Even='First_Half_Odd_Even';
  static const First_Goal_Last_Goal='First_Goal_Last_Goal';
  static const First_Half_Correct_Score='First_Half_Correct_Score';
  static const Double_Chance='Double_Chance';
  static const Asian_1X2='Asian_1X2';
  static const First_Half_Asian_1X2='First_Half_Asian_1X2';
  static const Specials='Specials';
}

//will be stored in db, class is no need anymore
class SportTypes
{
  static const Football='Football';
  static const Basketball='Basketball';
  static const Baseball='Baseball';
  static const Tennis='Tennis';
  static const AmericanFootball='AmericanFootball';
  static const Athletics='Athletics';
  static const Badminton='Badminton';
  static const BeachSoccer='BeachSoccer';
  static const Boxing='Boxing';
  static const Cricket='Cricket';
  static const Cycling='Cycling';
  static const Darts='Darts';
  static const Entertainment='Entertainment';
  static const FieldHockey='FieldHockey';
  static const Financial='Financial';
  static const Futsal='Futsal';
  static const Golf='Golf';
  static const Handball='Handball';
  static const IceHockey='IceHockey';
  static const Lacrosse='Lacrosse';
  static const MixedMartialArts='MixedMartialArts';
  static const MotorSport='MotorSport';
  static const Olympic='Olympic';
  static const Pool_Snooker='Pool_Snooker';
  static const Rugby='Rugby';
  static const Squash='Squash';
  static const TableTennis='TableTennis';
  static const Volleyball='Volleyball';
  static const WaterPolo='WaterPolo';
  static const WinterSports='WinterSports';
}