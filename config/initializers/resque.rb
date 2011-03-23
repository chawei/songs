require 'resque'

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load_file(rails_root + '/config/resque.yml')
Resque.redis = resque_config[rails_env]


require 'resque/server'

Songs::Application.routes.draw do 
  mount Resque::Server.new, :at => "/resque" 
end