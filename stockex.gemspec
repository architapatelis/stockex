# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "stockex"
  spec.version       = "0.1.0"
  spec.authors       = ["Archita Patel"]
  spec.email         = ["architapatelis@gmail.com"]

  spec.summary       = %q{Stock Exchange gem}
  spec.description   = %q{Stockex is a Ruby Gem used for fetching realtime and historical stock market data.}
  spec.homepage      = "https://github.com/architapatelis/stockex"
  spec.license       = "MIT"

  spec.files         = Dir['lib/stockex.rb', 'lib/**/*.rb']
  spec.require_paths = ["lib"]


  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'httparty', '~> 0.13'
  spec.add_runtime_dependency 'json', '~> 2.1.0'

end
