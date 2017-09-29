require "spec_helper"

RSpec.describe Stockex do

  before do
    Stockex.configure do |config|
      config.api_key = "YOURAPIKEYGOESHERE"
    end
  end

  it "should configure the right api_key" do
    expect(Stockex.configuration.api_key).to eq "YOURAPIKEYGOESHERE"
  end
end
