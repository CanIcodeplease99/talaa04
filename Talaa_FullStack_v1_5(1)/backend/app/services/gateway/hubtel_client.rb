require_relative 'base_client'
module Gateway
  class HubtelClient < BaseClient
    def initialize; super(base: ENV['HUBTEL_BASE']); end
    def payout_momo(msisdn:, network:, amount_cents:, reference:)
      amt=(amount_cents/100.0).round(2)
      res=post('/payout/mobilemoney', {customerMsisdn:msisdn, network:network, amount:amt, clientRef:reference})
      ok=res.status.between?(200,299)
      {ok:ok, status:(ok ? 'accepted':'failed'), raw:res.body}
    rescue => e; {ok:false, status:'failed', error:e.message}; end
    def health; get('/health').status.between?(200,299) ? 'healthy' : 'degraded'; rescue; 'down'; end
  end
end
