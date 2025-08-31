module FX
  class Orchestrator
    def initialize(provider: 'wise')
      @provider = (provider=='thunes') ? ThunesProvider.new : WiseProvider.new
    end
    def quote(source:, target:, amount:); @provider.quote(source:source, target:target, amount:amount); end
    def trade_and_payout(source_currency:, source_amount:, target_currency:, recipient_msisdn:, recipient_network:, reference:)
      @provider.trade_and_payout(source_currency:source_currency, source_amount:source_amount,
        target_currency:target_currency, recipient_msisdn:recipient_msisdn, recipient_network:recipient_network, reference:reference)
    end
  end
end
