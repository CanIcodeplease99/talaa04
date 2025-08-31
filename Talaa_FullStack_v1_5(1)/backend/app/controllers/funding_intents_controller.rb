class FundingIntentsController < ApplicationController
  def create
    amount_cents = (params[:amount].to_f*100).to_i
    currency = (params[:currency]||'usd').downcase
    settlement_ref = params[:settlement_ref] || "fund_#{SecureRandom.hex(6)}"
    fi = FundingIntent.create!(provider:'stripe', amount_cents: amount_cents, currency: currency, status:'requires_confirmation')
    pi = FundingStripe.create_intent(amount_cents: amount_cents, currency: currency, settlement_ref: settlement_ref)
    fi.update!(provider_ref: pi[:id], client_secret: pi[:client_secret], status:'requires_action')
    Metrics.inc(:funding_intents_created)
    render json:{funding_intent_id: fi.id, client_secret: fi.client_secret}
  end
end
