module Sector
  def self.included(stocks)
    stocks.extend(ClassMethods)
  end

  module ClassMethods
    @@base_uri = "https://www.alphavantage.co/query?"

    def get_sector_performance(apikey)
      begin
        response = HTTParty.get("#{@@base_uri}function=SECTOR&apikey=#{apikey}")
      rescue
        return "Oops! It seems you have a bad URI, please make sure the parameters are valid."
      else
        @data = JSON.parse(response.body)
        check_if_data_is_valid(limit=nil)
      end

    end
  end
end
