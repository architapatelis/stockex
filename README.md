# Stockex

Stockex is a Ruby Gem used for fetching realtime and historical stock market data.

To learn more about the API used for this gem visit - https://www.alphavantage.co/documentation/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stockex'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stockex

## Usage examples:

### Setup API key

In order to use the methods from this gem you will need to get an API key from - https://www.alphavantage.co/support/#api-key

You will need to use your API key when you call methods in Stockex. Your API should be a String value.  

To configure your API Key, place the following code in your application:

```ruby

Stockex.configure do |config|
  config.api_key = ENV['STOCKEX_KEY']
end

```
Use a variable to store your API Key:

```ruby

apikey = Stockex.configuration.api_key # => "YOURAPIKEY"

```

#### Intraday Values:

To get values for _intraday time series_ (timestamp, open, high, low, close, volume):

  - sym - is the symbol(a String value) for the Stock you want to get data on
  - interval -  the following String values are supported: 1min, 5min, 15min, 30min, 60min
  - outputsize : Strings `compact` and `full` are accepted. `compact` returns only the latest 100 data points; `full` returns the full-length time series of up to 20 years of historical data.

[Sample](https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=15min&outputsize=full&apikey=demo)

```ruby
Stockex::Equity.get_time_series_intraday(sym, interval, outputsize, apikey, limit=nil)

```

```ruby
Stockex::Equity.get_time_series_intraday("MSFT","30min", "full", "YOURAPIKEY")

```
You can set a `limit` for the number of data points you want to get. In the example below you will only get back the first 2 data points.

```ruby

Stockex::Equity.get_time_series_intraday("GOOGL", "30min", "compact", "YOURAPIKEY", 2)

```

#### Daily Values:

To get values for _daily time series_ (date, daily open, daily high, daily low, daily close, daily volume) of the equity specified, covering up to 20 years of historical data.

[Sample](https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&outputsize=full&apikey=demo)

```ruby
Stockex::Equity.get_time_series_daily(sym, outputsize, apikey, limit=nil)

Stockex::Equity.get_time_series_daily("GOOGL", "full", "YOURAPIKEY" 3)

```
You can also set a `limit` for the number of data points you want to get. In the example below you will only get back the first 2 data points.

```ruby

Stockex::Equity.get_time_series_daily("GOOGL", "compact", "YOURAPIKEY", 3)

```

#### Weekly Values:

To get values for _weekly time series_ (last trading day of each week, weekly open, weekly high, weekly low, weekly close, weekly volume) of the equity specified, covering up to 20 years of historical data.

[Sample](https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo)

```ruby
Stockex::Equity.get_time_series_weekly(sym, apikey, limit=nil)

Stockex::Equity.get_time_series_weekly("TSLA", "YOURAPIKEY")

Stockex::Equity.get_time_series_weekly("GOOGL", "YOURAPIKEY", 3)

```

**Note:** There are other methods in `Class Equity`. You may look at stockex/equity.rb for more detail.

### Indicator Methods

Technical indicator values are updated realtime: the latest data point is derived from the current trading day of a given equity.

Available values:
  - OBV: on balance volume
  - A/D Line: Chaikin A/D line
  - ADX: average directional movement index
  - Aroon: Aroon values
  - SMA: simple moving average
  - RSI: relative strength index

#### OBV

This method returns the on balance volume (OBV) values

[Sample](https://www.alphavantage.co/query?function=OBV&symbol=MSFT&interval=weekly&apikey=demo)

```ruby
Stockex::Equity.get_obv(sym, interval, apikey, limit=nil)

Stockex::Equity.get_obv("TSLA", "30min", "YOURAPIKEY")

Stockex::Equity.get_obv("GOOGL", "monthly", "YOURAPIKEY", 3)

```

### Sector Performance

This method returns the realtime and historical sector performances calculated from S&P500 incumbents.

[Sample](https://www.alphavantage.co/query?function=SECTOR&apikey=demo)

```ruby

Stockex::Equity.get_sector_performance("YOURAPIKEY")

```

### Additional Methods

```ruby
Stockex::Equity.get_value_for_specific_month("MSFT", 2016, 12, "YOURAPIKEY")

Stockex::Equity.get_value_for_specific_year("MSFT", 2016, "YOURAPIKEY")

Stockex::Equity.get_current_high('MSFT', "YOURAPIKEY")

Stockex::Equity.get_current_low('MSFT', "YOURAPIKEY")

Stockex::Equity.get_current_volume('MSFT', "YOURAPIKEY")

```

## Contributing to Stockex

Stockex is open source and contributions from the community are welcome on GitHub at https://github.com/architapatelis/stockex.

Please consider:

  - Adding a feature
  - Fixing a bug
  - Writing documentation
  - Fixing a typo

### How do I contribute?


  - Fork the project and clone it locally.
  - Write a failing test:
    - You can write the test in the `test/run_sample_test.rb` file.
    - To prevent an accidental push of your API code, it's best to:
      - copy the code from `run_sample_test.rb` to a .dot file (e.g: `test/.local_test_samples.rb`),
      - add this .dot file to your `.gitignore` directory.
      - You can do all your testing in this .dot file.
      - When you are happy with your work, make sure to write the test in the `run_sample_test.rb` file.
  - Commit changes that fix the tests.
  - Submit a pull request.

### Bug Reports

If you are experiencing unexpected behavior and, after having read the documentation, are convinced this behavior is a bug, please:

  - Search existing issues.
  - Collect enough information to reproduce the issue:
    - Stockex version
    - Ruby version
    - Specific setup conditions
    - Description of expected behavior
    - Description of actual behavior
  - Submit an issue.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
