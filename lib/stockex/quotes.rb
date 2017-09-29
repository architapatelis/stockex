module Quotes
  def self.included(stocks)
    stocks.extend(ClassMethods)
  end

  module ClassMethods
    @@base_uri = "https://www.alphavantage.co/query?"

# # 1
=begin
  * This method returns intraday time series (timestamp, open, high, low, close, volume) of the equity specified, updated realtime.
  * interval - following values are supported: 1min, 5min, 15min, 30min, 60min
  * outputsize - Strings compact and full are accepted with the following specifications:
    # compact returns only the latest 100 data points;
    # full returns the full-length time series of up to 20 years of historical data.
  *The "compact" option is recommended if you would like to reduce the data size of each API call.
=end
    def get_time_series_intraday(sym, interval, outputsize, apikey, limit=nil)
      if sym.is_a?(String) && interval.is_a?(String) && outputsize.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=TIME_SERIES_INTRADAY&symbol=#{sym}&interval=#{interval}&outputsize=#{outputsize}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Time Series (#{interval})"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure that the parameters sym, interval and outputsize are all Strings."
      end
    end

# # 2
=begin
  * This API returns daily time series (date, daily open, daily high, daily low, daily close, daily volume) of the equity specified, covering up to 20 years of historical data.
  * outputsize - Strings compact and full are accepted with the following specifications:
    # compact returns only the latest 100 data points;
    # full returns the full-length time series of up to 20 years of historical data.
  *The "compact" option is recommended if you would like to reduce the data size of each API call.
=end
    def get_time_series_daily(sym, outputsize, apikey, limit=nil)
      if sym.is_a?(String) && outputsize.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=TIME_SERIES_DAILY&symbol=#{sym}&outputsize=#{outputsize}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Time Series (Daily)"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure that the parameters sym and outputsize are Strings."
      end
    end

# # 3
=begin
  * This API returns daily time series (date, daily open, daily high, daily low, daily close, daily volume, daily adjusted close, and split/dividend events) of the equity specified, covering up to 20 years of historical data.

  * outputsize - Strings compact and full are accepted with the following specifications:
    # compact returns only the latest 100 data points;
    # full returns the full-length time series of up to 20 years of historical data.
  *The "compact" option is recommended if you would like to reduce the data size of each API call.
=end

    def get_time_series_daily_adjusted(sym, outputsize, apikey, limit=nil)
      if sym.is_a?(String) && outputsize.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=TIME_SERIES_DAILY_ADJUSTED&symbol=#{sym}&outputsize=#{outputsize}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Time Series (Daily)"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure that the parameters sym and outputsize are Strings."
      end
    end

# # 4
=begin
  * This API returns weekly time series (last trading day of each week, weekly open, weekly high, weekly low, weekly close, weekly volume) of the equity specified, covering up to 20 years of historical data.
=end
    def get_time_series_weekly(sym, apikey, limit=nil)
      if sym.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=TIME_SERIES_WEEKLY&symbol=#{sym}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Weekly Time Series"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure that the parameter sym is a String."
      end
    end

# # 5
=begin
  * This API returns monthly time series (last trading day of each month, monthly open, monthly high, monthly low, monthly close, monthly volume) of the equity specified, covering up to 20 years of historical data.
=end
    def get_time_series_monthly(sym, apikey, limit=nil)
      if sym.is_a?(String)
        begin
          response = HTTParty.get("#{@@base_uri}function=TIME_SERIES_MONTHLY&symbol=#{sym}&apikey=#{apikey}")
        rescue
          return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
        else
          @data = JSON.parse(response.body)
          @key_phrase = "Monthly Time Series"

          check_if_data_is_valid(limit)
        end
      else
        "Please make sure that the parameter sym is a String."
      end
    end

=begin
  * Equity::Stocks.get_value_for_specific_month("MSFT", 2016, 12)
      => {"open"=>60.11, "high"=>64.1, "low"=>58.8, "close"=>62.14, "volume"=>513579428.0}
=end
    def get_value_for_specific_month(sym, year, month, apikey)
      if sym.is_a?(String) && year.is_a?(Fixnum) && month.is_a?(Fixnum)
        if month < 0 || month > 12
          return "The month must be a  number between 1 and 12"
        else
          m = month.to_s
          if m.length == 1
            month = "0#{m}"
          end
          date = "#{year}-#{month}"

          data = get_time_series_monthly(sym, apikey)
          data.keys.find do |k|
            if k.to_s.include?(date)
              @key = k
            end
          end
          if data[@key].nil?
            "Sorry, there is no information avialable for this time period"
          else
            data[@key]
          end
        end
      else
        "Please make sure that sym is a String and year and month are Numerical"
      end
    end

    # will give values (open, high, low, close, volume) for specified year
    # Equity::Stocks.get_value_for_specific_year("MSFT", 2016)

    def get_value_for_specific_year(sym, year, apikey)
      if sym.is_a?(String) && year.is_a?(Fixnum)
        response = {}
        year = year.to_s
        data = get_time_series_monthly(sym, apikey)
        data.keys.each do |k|
          if k.to_s.include?(year)
            @key = k
            response[@key] = data[@key]
          end
        end
        if response.empty?
          "Sorry, there is no information avialable for this time period"
        else
          response
        end
      else
        "Please make sure that sym is a String and year is Numerical"
      end
    end

    # Equity::Stocks.get_current_high('MSFT') => 73.9
    def get_current_high(sym, apikey)
      get_curret_value(sym, "high", apikey)
    end

    # Equity::Stocks.get_current_low('MSFT') => 73.84
    def get_current_low(sym, apikey)
      get_curret_value(sym, "low", apikey)
    end

    # Equity::Stocks.get_current_volume('MSFT') => 1775240
    def get_current_volume(sym, apikey)
      get_curret_value(sym, "volume", apikey)
    end
  end
end
