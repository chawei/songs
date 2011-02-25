#config/initializers/omniauth.rb
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  'w4wX3GoEZTUpKLNZBfHXw', 'PNr3uhnXzT9sczvvEs129dCDf5z6lSQIqmSre4sL88'
  provider :facebook, '119902858073845', '7e3cf5151047100e0df9dd923fa42b5e' #songs
  #provider :facebook, '161415880575187', 'c31c677a3335ff2f91b773b6c1f40ed7' #songBERG
  provider :linked_in, 'KEY', 'SECRET'
  provider :open_id,  OpenID::Store::Filesystem.new('/tmp')
end
# you will be able to access the above providers by the following url
# /auth/providername for example /auth/twitter /auth/facebook

Rails.application.config.middleware do
  use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => "google",  :identifier => "https://www.google.com/accounts/o8/id"
  #use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => "yahoo",   :identifier => "https://me.yahoo.com"
  #use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => "aol",     :identifier => "https://openid.aol.com"
  #use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), :name => "myspace", :identifier => "http://myspace.com"
end
# you won't be able to access the openid urls like /auth/google
# you will be able to access them through
# /auth/open_id?openid_url=https://www.google.com/accounts/o8/id
# /auth/open_id?openid_url=https://me.yahoo.com