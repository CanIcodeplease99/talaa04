Rails.application.routes.draw do
  scope "/v1" do
    get  "direct_deposit", to: "banking#direct_deposit"
    post "cards/virtual", to: "cards#virtual"
    post "cards/tokenize", to: "cards#tokenize"
    post "transfers", to: "payments#transfer"
    post "transfers/intl", to: "payments#transfer_international"
    post "quotes/fx", to: "quotes#fx"
    get  "rails/health", to: "rails#health"
    post "waitlist", to: "waitlist#create"
    get  "settlements/:id", to: "settlements#show"
    post "fund/stripe_intent", to: "funding#stripe_intent"
    post "webhooks/stripe", to: "webhooks#stripe"
    post "lumi/chat", to: "lumi#chat"
  end
end
