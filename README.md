# 🚨 Trading Alert: Avoid CFDs 🚨

**_Warning_:**  
Trading Contracts for Difference (CFDs) can be extremely risky. Due to high leverage and volatility, CFDs can expose you to losses that exceed your initial investment—**potentially resulting in the loss of all your money**. 

**🔔 _Recommendation_:**  
For a safer trading environment, consider trading on **SPOT markets** (such as crypto spot or forex spot) where you are dealing with actual assets. SPOT trading generally involves lower leverage, which may reduce the risk of significant losses.  

**💡 _Reminder_:**  
- Always use proper risk management techniques.  
- Only trade with capital you can afford to lose.  
- Make sure to do thorough research or consult with a qualified financial advisor before making any trading decisions.

**_Disclaimer_:**  
This alert is provided for informational purposes only and does **not** constitute financial advice.



# TRAMA

**TRAMA** is a custom trend indicator for MetaTrader 4 that is inspired by the Trend Regularity Adaptive Moving Average developed by LuxAlgo on TradingView. This indicator dynamically adapts to market regularity by calculating an adaptive moving average based on a custom look-back period. In practice, if the market price is above the TRAMA, it indicates an uptrend; if below, it signals a downtrend.

### (Tradingview == MetaTrader4)                                                                                              
<img src="https://github.com/user-attachments/assets/360185cb-9c06-4b47-b7ff-e81272b74091" width="500" height="400"> 

<img src="https://github.com/user-attachments/assets/deb1c587-57e5-4dd8-884f-ab8c9ba8fbab" width="500" height="400">




## Key Features

- **LuxAlgo-Inspired Adaptive Moving Average:**  
  Draws inspiration from LuxAlgo’s Trend Regularity Adaptive Moving Average on TradingView, offering a modern approach to trend identification.

- **Dynamic Smoothing:**  
  Uses a custom algorithm to analyze recent highs and lows over a user-defined look-back period (via the `Length` parameter) to determine a dynamic smoothing factor. This factor adjusts the moving average responsiveness according to current market regularity.

- **Trend Determination:**  
  The resulting TRAMA line acts as a trend filter:
  - When the market price is above TRAMA, it suggests an uptrend.
  - When the market price is below TRAMA, it indicates a downtrend.

- **Applied Price Flexibility:**  
  Users can select which price to apply (open, high, low, or close) when computing the TRAMA, with close being the default.

## How It Works

1. **Look-Back Analysis:**  
   For each bar, the indicator scans a period defined by `Length` to capture the highest and lowest price values. This data is used to generate a simple signal that reflects whether the trend conditions are favorable.

2. **Smoothing Factor Calculation:**  
   The indicator computes a simple moving average of the signal over the look-back period, then squares the averaged result to derive an adaptive smoothing coefficient (tc). This coefficient adapts based on price regularity.

3. **TRAMA Computation:**  
   Using a recursive formula, the indicator blends the previous TRAMA value with the current source price (based on the selected `AppliedPrice`), weighted by the adaptive factor (tc). The computed values are stored in the main indicator buffer (`AmaBuffer`) and displayed as a continuous line on the chart.

4. **Trend Identification:**  
   A simple trading premise is followed:  
   - **Uptrend:** When the market price is above TRAMA  
   - **Downtrend:** When the market price is below TRAMA

## Installation

1. **Copy the Indicator File:**  
   Place the `TRAMA.mq4` file into your `MQL4/Indicators` folder.

2. **Compile:**  
   Open the file in MetaEditor and compile it. Check for any warnings and ensure the indicator compiles successfully.

3. **Attach to Chart:**  
   Open MetaTrader 4, navigate to the Navigator panel, and drag the TRAMA indicator onto your chart. The adaptive TRAMA line will be plotted directly in the chart window.

## Customization Options

- **Length (Look-Back Period):**  
  Modify the number of bars used to determine the high and low values (default is 1).

- **Applied Price:**  
  Select which price type (Open, High, Low, Close) is used for calculations. The default is set to the Close price.

## Usage Notes

- **Trend Signal:**  
  Use the TRAMA line as a trend filter:
  - If the current price is above TRAMA, the trend is up.
  - If the current price is below TRAMA, the trend is down.
  
- **Complementary Tool:**  
  This indicator is designed to visually assess trend direction quickly. Combine it with other technical analysis tools (such as oscillators or support/resistance levels) for robust trading strategies.

- **Performance Considerations:**  
  Since the indicator utilizes a recursive algorithm based on historical data, ensure that your chart has sufficient data for accurate calculation.

## License

This indicator is open-source. Please refer to the LICENSE file for details regarding permitted usage and distribution.

## Credits

Developed by [Seif Rached](https://github.com/seifrached/). Inspired by the Trend Regularity Adaptive Moving Average by LuxAlgo on TradingView, this indicator is aimed at providing traders with a cutting-edge trend filtering tool.

