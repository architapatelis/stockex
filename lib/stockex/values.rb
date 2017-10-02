
module Values

  def self.included(equity)
    equity.extend(ClassMethods)
  end

  module ClassMethods

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
