source 'https://rubygems.org'

gem 'ruby_aem', '~> 1.0.4'
gem 'nokogiri', '~> 1.6.8'

group :lint do
  gem 'puppet-lint', require: false
end

if puppetversion = ENV['PUPPET_VERSION']
  gem 'puppet', puppetversion, require: false
else
  gem 'puppet', require: false
end
