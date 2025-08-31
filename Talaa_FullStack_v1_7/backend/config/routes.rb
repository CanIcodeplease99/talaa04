Rails.application.routes.draw do
  devise_for :admin_users, path: 'auth'
  authenticate :admin_user do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  scope "/v1" do
    post "transfers",          to: "payments#transfer"
    post "transfers/intl",     to: "payments#transfer_international"
    post "quotes/fx",          to: "quotes#fx"
    post "funding/intents",    to: "funding_intents#create"
    post "webhooks/stripe",    to: "webhooks#stripe"
    post "kyc/start",          to: "kyc#start"
    post "kyc/upload",         to: "kyc#upload"
    post "kyc/submit",         to: "kyc#submit"
    get  "rails/health",       to: "rails#health"
  end

  get  "/metrics", to: "metrics#show"
end
