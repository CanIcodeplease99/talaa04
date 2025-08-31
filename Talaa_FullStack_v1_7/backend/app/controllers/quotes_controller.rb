class QuotesController < ApplicationController
  def fx
    amt=params[:amount].to_f
    Metrics.inc(:fx_quotes_requested)
    provider = ENV.fetch('FX_PROVIDER','wise')
    quote = FX::Orchestrator.new(provider: provider).quote(source:'USD', target:(params[:target_currency]||'GHS'), amount: amt)
    render json: quote.merge(lock_expires_at: (Time.now+60).iso8601)
  end
end
