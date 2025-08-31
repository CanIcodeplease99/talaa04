require 'prometheus/client'
module Metrics
  extend self
  REGISTRY = Prometheus::Client.registry
  COUNTERS = {
    transfers_created:REGISTRY.counter(:talaa_transfers_created,'Transfers created'),
    transfers_sent_ok:REGISTRY.counter(:talaa_transfers_sent_ok,'Transfers sent ok'),
    transfers_failed:REGISTRY.counter(:talaa_transfers_failed,'Transfers failed'),
    fx_quotes_requested:REGISTRY.counter(:talaa_fx_quotes_requested,'FX quotes requested'),
    fx_trades_started:REGISTRY.counter(:talaa_fx_trades_started,'FX trades started'),
    fx_trades_ok:REGISTRY.counter(:talaa_fx_trades_ok,'FX trades success'),
    fx_trades_failed:REGISTRY.counter(:talaa_fx_trades_failed,'FX trades failed'),
    funding_intents_created:REGISTRY.counter(:talaa_funding_intents_created,'Funding intents created'),
    funding_cleared:REGISTRY.counter(:talaa_funding_cleared,'Funding cleared via Stripe')
  }
  def inc(name, by:1); COUNTERS[name]&.increment(by:by); end
  def export; Prometheus::Client::Formats::Text.marshal(REGISTRY); end
end
