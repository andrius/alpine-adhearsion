source 'https://rubygems.org'

# Adhearsion 3.0.0rc1
gem 'adhearsion', github: 'adhearsion/adhearsion'

group :asterisk do
  gem 'adhearsion-asterisk', github: 'adhearsion/adhearsion-asterisk', branch: 'adhearsion-3'
end

group :api do
  gem 'hashie'

  gem 'faraday', '>= 0.9.2'
  gem 'net-http-persistent'
  gem 'faraday-http-cache'
  gem 'json'
  gem 'multi_xml'
end

# gem 'tzinfo'
# gem 'tzinfo-data'
# gem 'activesupport', require: %w( active_support/time_with_zone
#                                   active_support/core_ext/time/zones)

group :development, :test do
  gem 'rspec'
end

