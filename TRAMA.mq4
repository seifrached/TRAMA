//+------------------------------------------------------------------+
//|                                               TRAMA.mq4          |
//|                                  Inspired from TradingView       |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 clrRed
#property indicator_width1 2
#property indicator_style1 STYLE_SOLID

//--- input parameters
extern int Length = 144;                              // Look-back period
extern ENUM_APPLIED_PRICE AppliedPrice = PRICE_CLOSE; // Applied Price

//--- indicator buffer
double AmaBuffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{

   IndicatorBuffers(1);
   SetIndexBuffer(0, AmaBuffer);
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 4, clrBlack);
   IndicatorShortName("TRAMA [LuxAlgo]");
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{

   if(rates_total < Length)
      return(0);


   double signal[];
   double smaSignal[];
   double tc[];
   
   ArrayResize(signal, rates_total);
   ArrayResize(smaSignal, rates_total);
   ArrayResize(tc, rates_total);


   for(int iSig = rates_total - Length; iSig >= 0; iSig--)
   {

      double highest_i = high[iSig];
      double lowest_i  = low[iSig];
      for(int j = iSig; j < iSig + Length; j++)
      {
         if(high[j] > highest_i)
            highest_i = high[j];
         if(low[j] < lowest_i)
            lowest_i = low[j];
      }
      

      double highest_ip1 = highest_i, lowest_ip1 = lowest_i;
      if(iSig + 1 <= rates_total - Length)
      {
         highest_ip1 = high[iSig+1];
         lowest_ip1 = low[iSig+1];
         for(int k = iSig + 1; k < iSig + 1 + Length; k++)
         {
            if(high[k] > highest_ip1)
               highest_ip1 = high[k];
            if(low[k] < lowest_ip1)
               lowest_ip1 = low[k];
         }
      }
      

      int hh = ((highest_i - highest_ip1) > 0) ? 1 : 0;
      int ll = ((lowest_ip1 - lowest_i) > 0) ? 1 : 0;
      signal[iSig] = (hh == 1 || ll == 1) ? 1.0 : 0.0;
   }
   

   for(int iSMA = rates_total - Length; iSMA >= 0; iSMA--)
   {
      double sum = 0.0;
      for(int j2 = iSMA; j2 < iSMA + Length; j2++)
         sum += signal[j2];
      smaSignal[iSMA] = sum / Length;
      tc[iSMA] = smaSignal[iSMA] * smaSignal[iSMA];
   }
   
   double src[];
   ArrayResize(src, rates_total);
   for(int iPrice = 0; iPrice < rates_total; iPrice++)
   {
      switch(AppliedPrice)
      {
         case PRICE_OPEN:
            src[iPrice] = open[iPrice];
            break;
         case PRICE_HIGH:
            src[iPrice] = high[iPrice];
            break;
         case PRICE_LOW:
            src[iPrice] = low[iPrice];
            break;
         case PRICE_CLOSE:
         default:
            src[iPrice] = close[iPrice];
            break;
      }
   }

   for(int iAMA = rates_total - 1; iAMA >= 0; iAMA--)
   {
      if(iAMA > rates_total - Length)
         AmaBuffer[iAMA] = src[iAMA];
      else
      {
         if(iAMA == rates_total - Length)
            AmaBuffer[iAMA] = src[iAMA];
         else
            AmaBuffer[iAMA] = AmaBuffer[iAMA+1] + tc[iAMA]*(src[iAMA] - AmaBuffer[iAMA+1]);
      }
   }
   
   return(rates_total);
}

