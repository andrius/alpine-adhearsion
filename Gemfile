source 'https://rubygems.org'

group :alpine_linux do
  gem 'ffi', '= 1.9.14'
end

# Adhearsion 3.0.0rc1
gem 'adhearsion', github: 'adhearsion/adhearsion'
gem 'matrioska', github: 'adhearsion/matrioska', branch: 'feature/adhearsion-3'

group :asterisk do
  gem 'adhearsion-asterisk', github: 'adhearsion/adhearsion-asterisk', branch: 'adhearsion-3'
end

group :web, :api do
  gem 'sinatra', require: false
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-expectations'
end

