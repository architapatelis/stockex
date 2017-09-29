module Indicators
  def self.included(stocks)
    stocks.extend(ClassMethods)
  end

  module ClassMethods
    @@base_uri = "https://www.alphavantage.co/query?"

=begin
  * This API returns the on balance volume (OBV) values.

  * interval - the following values are supported: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly
=end
    def get_obv(sym, interval, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=OBV&symbol=#{sym}&interval=#{interval}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Technical Analysis: OBV"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure sym and interval are String values."
      end
    end

=begin
  * This API returns the Chaikin A/D line (AD) values.

  * interval - the following values are supported: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly
=end
    def get_ad_line(sym, interval, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=AD&symbol=#{sym}&interval=#{interval}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Technical Analysis: Chaikin A/D"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure sym and interval are String values."
      end
    end

=begin
  * This API returns the average directional movement index (ADX) values

  * interval - the following values are supported: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly

  * time_period - Number of data points used to calculate each ADX value. Positive integers are accepted (e.g., time_period=60, time_period=200)
=end
    def get_adx(sym, interval, time_period, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String) && time_period.is_a?(Fixnum)
        begin
          response = HTTParty.get("#{@@base_uri}function=ADX&symbol=#{sym}&interval=#{interval}&time_period=#{time_period}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Technical Analysis: ADX"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure sym and interval are String values, and time_period is Numeric."
      end
    end

=begin
  * This API returns the Aroon (AROON) values.

  * interval - the following values are supported: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly

  * time_period - Number of data points used to calculate each ADX value. Positive integers are accepted (e.g., time_period=60, time_period=200)
=end
    def get_aroon(sym, interval, time_period, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String) && time_period.is_a?(Fixnum)
        begin
          response = HTTParty.get("#{@@base_uri}function=AROON&symbol=#{sym}&interval=#{interval}&time_period=#{time_period}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Technical Analysis: AROON"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure sym and interval are String values, and time_period is Numeric."
      end
    end


=begin
  * This API returns the simple moving average (SMA) values.

  * interval - the following values are supported: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly

  * time_period - Number of data points used to calculate each moving average value. Positive integers are accepted (e.g., time_period=60, time_period=200)

  * series_type - The desired price type in the time series. Four types are supported: close, open, high, low
=end
    def get_sma(sym, interval, time_period, series_type, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String) && time_period.is_a?(Fixnum) && series_type.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=SMA&symbol=#{sym}&interval=#{interval}&time_period=#{time_period}&series_type=#{series_type}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Technical Analysis: SMA"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure sym, interval and series_type are String values, and time_period is Numeric."
      end
    end

=begin
  * This API returns the simple moving average (SMA) values.

  * interval - the following values are supported: 1min, 5min, 15min, 30min, 60min, daily, weekly, monthly

  * time_period - Number of data points used to calculate each moving average value. Positive integers are accepted (e.g., time_period=60, time_period=200)

  * series_type - The desired price type in the time series. Four types are supported: close, open, high, low
=end
    def get_rsi(sym, interval, time_period, series_type, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String) && time_period.is_a?(Fixnum) && series_type.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=RSI&symbol=#{sym}&interval=#{interval}&time_period=#{time_period}&series_type=#{series_type}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Technical Analysis: RSI"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure sym, interval and series_type are String values, and time_period is Numeric."
      end
    end

  end
end
