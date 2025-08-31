module Gateway
  class DomesticRouter
    ORDER=%w[zeepay hubtel]
    def transfer_mobile_money(msisdn:, network:, amount_cents:, reference:, idempotency_key:)
      ORDER.each do |name|
        client={'zeepay'=>ZeepayClient.new, 'hubtel'=>HubtelClient.new}[name]
        next unless rail_enabled?(name)
        resp=client.payout_momo(msisdn:msisdn, network:network, amount_cents:amount_cents, reference:reference)
        return {provider:name, status:resp[:status], ok:resp[:ok], raw:resp[:raw]} if resp[:ok]
      end
      {provider:ORDER.first, status:'failed', ok:false, error:'no provider available'}
    end
    private
    def rail_enabled?(name); Rails.cache.fetch("rail:gh:#{name}:enabled"){ true }; end
  end
end
