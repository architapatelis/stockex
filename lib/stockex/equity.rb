require "httparty"
require 'json'
require 'stockex/quotes'
require 'stockex/indicators'
require 'stockex/sector'
require 'stockex/values'


module Stockex
  class Equity
    extend HTTParty
    include Quotes
    include Values
    include Indicators
    include Sector

    private

=begin
  * Make sure that the object recieved in the response, is valid. If there is an error message let the user know that there is something wrong with the API request.
=end
    def self.check_if_data_is_valid(limit)
      if @data.has_key?("Error Message")
        return "ERROR! Sorry, the API call was not succsseful please check that the parameters are valid"
      else
        get_limited_or_all_data(limit)
      end

    end

=begin
  * If user has specified limit, then get limited data for them. Else get all data
=end
    def self.get_limited_or_all_data(limit)
      if limit !=nil
        if limit.is_a?(Fixnum) && limit > 0
          response = get_limited_data(@data, limit, @key_phrase)
          modify_key_and_value(response)
        else
          return "Sorry, the limit must be a positive number"
        end
      elsif limit == nil
        response = get_all_data(@data, @key_phrase)
        modify_key_and_value(response)
      end
    end

    # get_limited_data(@data, 2, @key_phrase)
    # this method will remove meta data
    # it will return limited data points
    def self.get_limited_data(data, limit, key_phrase)
        limited_data_hash = data.each {|k, v| return v.first(limit).to_h if k == key_phrase}
      return limited_data_hash
    end

    # get_all_data(@data, @key_phrase)
    # will remove meta data
    # will return all data objects
    def self.get_all_data(data, key_phrase)
      all_data = data.each {|k, v| return v if k == key_phrase}
      return all_data
    end

    # used to convert  key into string and value into integer
    def self.modify_key_and_value(data)
      data.to_a.each do |item|
        key = item[0]
        to_modify =item[1].to_a

        to_modify.each do |i|
          if i[0].include?(".")
            i[0] = i[0].to_s.slice(3..-1)
          else
            i[0] = i[0].to_s
          end
          i[1] = i[1].to_f
        end
        data[key] = to_modify.to_h
      end
      return data
    end

    # to get current, high, low or volume values.
    def self.get_curret_value(sym, value, apikey)
      if sym.is_a?(String)
        data = get_time_series_intraday(sym, "1min", "compact", apikey, 1)
        data[data.keys[0]][value]
      else
        "Please make sure that sym is a String."
      end
    end
  end
end
