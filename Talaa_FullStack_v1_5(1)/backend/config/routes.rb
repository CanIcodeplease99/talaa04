Rails.application.routes.draw do
  scope "/v1" do
    post "transfers",          to: "payments#transfer"
    post "transfers/intl",     to: "payments#transfer_international"
    post "quotes/fx",          to: "quotes#fx"
    post "funding/intents",    to: "funding_intents#create"
    post "webhooks/stripe",    to: "webhooks#stripe"
    get  "rails/health",       to: "rails#health"
  end
  get  "/metrics", to: "metrics#show"
end
