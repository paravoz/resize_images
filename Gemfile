source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'apitome', '~> 0.1.0'
gem 'carrierwave-mongoid', '~> 0.10.0', require: 'carrierwave/mongoid'
gem 'jsonapi-serializers', '~> 1.0'
gem 'kaminari-mongoid', '~> 1.0', '>= 1.0.1'
gem 'mini_magick', '~> 4.7'
gem 'mongoid', '~> 6.1.0'

gem 'rails', '~> 5.1.0.rc1'
gem 'rspec_api_documentation', '~> 4.9'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: true
end

group :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'mongoid-rspec', github: 'mongoid-rspec/mongoid-rspec'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-callback-matchers'
  gem 'simplecov', require: false
end
