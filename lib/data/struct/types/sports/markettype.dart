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
   static const kAsian_Handicap=const MarketTypes._(Asian_Handicap);
   static const kOdd_Even=const MarketTypes._(Odd_Even);
   static const kOver_Under=const MarketTypes._(Over_Under);
   static const kCorrect_Score=const MarketTypes._(Correct_Score);
   static const kOneXTwo=const MarketTypes._(OneXTwo);
   static const kTotal_Goal=const MarketTypes._(Total_Goal);
   static const kFirst_Half_Asian_Handicap=const MarketTypes._(First_Half_Asian_Handicap);
   static const kFirst_Half_1X2=const MarketTypes._(First_Half_1X2);
   static const kFirst_Half_Over_Under=const MarketTypes._(First_Half_Over_Under);
   static const kHalf_Time_Full_Time=const MarketTypes._(Half_Time_Full_Time);
   static const kMoney_Line=const MarketTypes._(Money_Line);
   static const kFirst_Half_Odd_Even=const MarketTypes._(First_Half_Odd_Even);
   static const kFirst_Goal_Last_Goal=const MarketTypes._(First_Goal_Last_Goal);
   static const kFirst_Half_Correct_Score=const MarketTypes._(First_Half_Correct_Score);
   static const kDouble_Chance=const MarketTypes._(Double_Chance);
   static const kAsian_1X2=const MarketTypes._(Asian_1X2);
   static const kFirst_Half_Asian_1X2=const MarketTypes._(First_Half_Asian_1X2);
   static const kSpecials=const MarketTypes._(Specials);

   static final Map _keylist={
                       Asian_Handicap:kAsian_Handicap,
                       Odd_Even:kOdd_Even,
                       Over_Under:kOver_Under,
                       Correct_Score:kCorrect_Score,
                       OneXTwo:kOneXTwo,
                       Total_Goal:kTotal_Goal,
                       First_Half_Asian_Handicap:kFirst_Half_Asian_Handicap,
                       First_Half_1X2:kFirst_Half_1X2,
                       First_Half_Over_Under:kFirst_Half_Over_Under,
                       Half_Time_Full_Time:kHalf_Time_Full_Time,
                       Money_Line:kMoney_Line,
                       First_Half_Odd_Even:kFirst_Half_Odd_Even,
                       First_Goal_Last_Goal:kFirst_Goal_Last_Goal,
                       First_Half_Correct_Score:kFirst_Half_Correct_Score,
                       Double_Chance:kDouble_Chance,
                       Asian_1X2:kAsian_1X2,
                       First_Half_Asian_1X2:kFirst_Half_Asian_1X2,
                       Specials:kSpecials
                       };

   final String _key;
   String get key=>_key;

   static instance(String key)=>_keylist[key];

   const MarketTypes._(this._key);

   //operator==(MarketType obj)=>_key==obj._key;
 }