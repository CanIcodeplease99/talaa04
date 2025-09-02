# Add to routes.rb (outside /v1 scope, inside authenticate :admin_user)
namespace :admin do
  get 'summary', to: 'summary#index'
end
