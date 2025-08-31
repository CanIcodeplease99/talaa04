Devise.setup do |config|
  config.secret_key = ENV['DEVISE_SECRET_KEY'] || 'dev_key'
  config.mailer_sender = 'no-reply@talaa.local'
  require 'devise/orm/active_record'
end
