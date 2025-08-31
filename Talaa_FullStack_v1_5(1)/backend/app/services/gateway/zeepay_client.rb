require_relative 'base_client'; require_relative 'auth/signature'
module Gateway
  class ZeepayClient < BaseClient
    def initialize
      super(base: ENV['ZEEPAY_BASE'])
      @sign=Gateway::Auth::Signature.new(key:ENV['ZEEPAY_KEY'], secret:ENV['ZEEPAY_SECRET'],
        scheme:ENV.fetch('ZEEPAY_AUTH_SCHEME','HMAC_V1'),
        key_header:ENV.fetch('ZEEPAY_KEY_HEADER','X-Api-Key'),
        sig_header:ENV.fetch('ZEEPAY_SIG_HEADER','X-Signature'),
        ts_header: ENV.fetch('ZEEPAY_TS_HEADER','X-Timestamp'))
    end
    def payout_momo(msisdn:, network:, amount_cents:, reference:)
      amt=(amount_cents/100.0).round(2); path='/mobilemoney/payout'
      body={phone:msisdn, network:network, amount:amt, currency:'GHS', ref:reference}
      h=@sign.headers(method: :post, path: path, body_json: Oj.dump(body))
      res=post(path, body, h)
      ok=res.status.between?(200,299) && res.body.to_s.upcase.include?('ACCEPT')
      {ok:ok, status:(ok ? 'accepted':'failed'), raw:res.body, error:(res.body.is_a?(Hash) ? res.body['message'] : nil)}
    rescue => e; {ok:false, status:'failed', error:e.message}; end
    def health; path='/health'; h=@sign.headers(method: :get, path: path, body_json: ''); get(path, {}, h).status.between?(200,299) ? 'healthy' : 'degraded'; rescue; 'down'; end
  end
end
