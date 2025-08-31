RailsAdmin.config do |config|
  config.authenticate_with { warden.authenticate! scope: :admin_user }
  config.current_user_method(&:current_admin_user)
  config.included_models = ['Settlement','FundingIntent','UserKyc','AdminUser']
  config.main_app_name = ['Talaa Admin', '']
  config.actions { dashboard; index; show; edit; delete }
end
