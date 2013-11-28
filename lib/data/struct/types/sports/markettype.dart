library MarketTypes;

 const Asian_Handicap='Asian_Handicap';
 const Odd_Even='Odd_Even';
 const Over_Under='Over_Under';
 const Correct_Score='Correct_Score';
 const OneXTwo='OneXTwo';
 const Total_Goal='Total_Goal';
 const First_Half_Asian_Handicap='First_Half_Asian_Handicap';
 const First_Half_1X2='First_Half_1X2';
 const First_Half_Over_Under='First_Half_Over_Under';
 const Half_Time_Full_Time='Half_Time_Full_Time';
 const Money_Line='Money_Line';
 const First_Half_Odd_Even='First_Half_Odd_Even';
 const First_Goal_Last_Goal='First_Goal_Last_Goal';
 const First_Half_Correct_Score='First_Half_Correct_Score';
 const Double_Chance='Double_Chance';
 const Asian_1X2='Asian_1X2';
 const First_Half_Asian_1X2='First_Half_Asian_1X2';
 const Specials='Specials';

 class MarketTypes
 {
   static const _Asian_Handicap=const MarketTypes._(Asian_Handicap);
   static const _Odd_Even=const MarketTypes._(Odd_Even);
   static const _Over_Under=const MarketTypes._(Over_Under);
   static const _Correct_Score=const MarketTypes._(Correct_Score);
   static const _OneXTwo=const MarketTypes._(OneXTwo);
   static const _Total_Goal=const MarketTypes._(Total_Goal);
   static const _First_Half_Asian_Handicap=const MarketTypes._(First_Half_Asian_Handicap);
   static const _First_Half_1X2=const MarketTypes._(First_Half_1X2);
   static const _First_Half_Over_Under=const MarketTypes._(First_Half_Over_Under);
   static const _Half_Time_Full_Time=const MarketTypes._(Half_Time_Full_Time);
   static const _Money_Line=const MarketTypes._(Money_Line);
   static const _First_Half_Odd_Even=const MarketTypes._(First_Half_Odd_Even);
   static const _First_Goal_Last_Goal=const MarketTypes._(First_Goal_Last_Goal);
   static const _First_Half_Correct_Score=const MarketTypes._(First_Half_Correct_Score);
   static const _Double_Chance=const MarketTypes._(Double_Chance);
   static const _Asian_1X2=const MarketTypes._(Asian_1X2);
   static const _First_Half_Asian_1X2=const MarketTypes._(First_Half_Asian_1X2);
   static const _Specials=const MarketTypes._(Specials);

   static final Map _keylist={
                       Asian_Handicap:_Asian_Handicap,
                       Odd_Even:_Odd_Even,
                       Over_Under:_Over_Under,
                       Correct_Score:_Correct_Score,
                       OneXTwo:_OneXTwo,
                       Total_Goal:_Total_Goal,
                       First_Half_Asian_Handicap:_First_Half_Asian_Handicap,
                       First_Half_1X2:_First_Half_1X2,
                       First_Half_Over_Under:_First_Half_Over_Under,
                       Half_Time_Full_Time:_Half_Time_Full_Time,
                       Money_Line:_Money_Line,
                       First_Half_Odd_Even:_First_Half_Odd_Even,
                       First_Goal_Last_Goal:_First_Goal_Last_Goal,
                       First_Half_Correct_Score:_First_Half_Correct_Score,
                       Double_Chance:_Double_Chance,
                       Asian_1X2:_Asian_1X2,
                       First_Half_Asian_1X2:_First_Half_Asian_1X2,
                       Specials:_Specials
                       };

   final String _key;
   String get typeid=>_key;

   static types(String key)=>_keylist[key];

   const MarketTypes._(this._key);

   //operator==(MarketType obj)=>_key==obj._key;
 }