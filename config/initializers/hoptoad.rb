HoptoadNotifier.configure do |config|
  config.api_key = '9228944505af1a9cfe337ee475184b58'
  config.js_notifier = true unless ['test', 'edge'].include? RAILS_ENV
end
