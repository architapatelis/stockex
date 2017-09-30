require "spec_helper"


s = Stockex::Equity

#TODO: configure your api key here:

Stockex.configure do |config|
  config.api_key = "YOURAPIKEYHERE"
end

apikey = Stockex.configuration.api_key

#To run any of the test you can uncomment the methods below
# and in the console from the root directory run 'ruby test/run_sample_test.rb'

## Quotes methods:

#1
#p s.get_time_series_intraday("MSFT","30min", "compact", apikey) #works
#p s.get_time_series_intraday("GOOGL", "30min", "compact", apikey, 2) #works
#p s.get_time_series_intraday("#", "30min", "compact", apikey, 2) #API error message works
#p s.get_time_series_intraday("#", "#", "#", apikey, 2) #Bad URI error message works


#2
#p s.get_time_series_daily("MSFT", "full", apikey) #works
#p s.get_time_series_daily("MSFT", "compact", apikey, 3) #works
#p s.get_time_series_daily("MSFT", "#", apikey, 3) #API error message works
#p s.get_time_series_daily("#", "#", "#") #Bad URI error message works


#3
#p s.get_time_series_daily_adjusted("GOOGL", "full", apikey) #works
#p s.get_time_series_daily_adjusted("MSFT", "compact", apikey, 3) #works
#p s.get_time_series_daily_adjusted("MSFT", "compact", apikey, -3) #negative limit error works
#p s.get_time_series_daily_adjusted("GOOGL", "#", apikey) # API error message works
#p s.get_time_series_daily_adjusted("#", "#", "#") # Bad URI error message works


#4
#p s.get_time_series_weekly('GOOGL', apikey) #works
#p s.get_time_series_weekly("MSFT", apikey,  3) #works
#p s.get_time_series_weekly("#", "#") # Bad URI error message works
#p s.get_time_series_weekly("MSFT", apikey, "#") # invalid limit error works
#p s.get_time_series_weekly("GOOGL", apikey, -1) #negative limit error message works


#5
#p s.get_time_series_monthly("GOOGL", apikey) #works
#p s.get_time_series_monthly("GOOGL", apikey, 3) #works
#p s.get_time_series_monthly("#", apikey) # API error message works
#p s.get_time_series_monthly("#", "#") # Bad URI error message works

#6
#p s.get_value_for_specific_month("MSFT", 2016, 12, apikey) #works

#7
#p s.get_value_for_specific_year("MSFT", 2016, apikey) #works

#8
#p s.get_current_high('MSFT', apikey) #works

#9
#p s.get_current_low('MSFT', apikey) #works

#10
#p s.get_current_volume('MSFT', apikey) # works


#******************************************************************************

## Indicator Methods:

#p s.get_obv("GOOGL", "monthly", apikey, 3) #works
#p s.get_ad_line("GOOGL", "weekly", apikey, 4) #works
#p s.get_adx("GOOGL", "weekly", 10, apikey, 4) #works
#p s.get_aroon("GOOGL", "weekly", 100, apikey, 3) #work, s
#p s.get_sma("GOOGL", "15min", 10, "close", apikey, 3) #works
#p s.get_rsi("GOOGL", "15min", 10, "close", apikey, 3) #works

#******************************************************************************

## Sector Method:

#p s.get_sector_performance(apikey)
