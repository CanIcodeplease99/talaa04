require 'openssl'; require 'base64'; require 'digest'
module Gateway
  module Auth
    class Signature
      def initialize(key:, secret:, scheme:, key_header:'X-Api-Key', sig_header:'X-Signature', ts_header:'X-Timestamp')
        @key,@secret,@scheme,@key_header,@sig_header,@ts_header=key,secret,scheme,key_header,sig_header,ts_header
      end
      def headers(method:, path:, body_json:'')
        ts=Time.now.utc.iso8601; method=method.to_s.upcase
        return {'Authorization'=>"Bearer #{@key}"} if @scheme=='BEARER'
        bh=Digest::SHA256.hexdigest(body_json.to_s)
        to_sign=[method,path,ts,bh].join("\n")
        sig=Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', @secret, to_sign))
        {@key_header=>@key, @sig_header=>sig, @ts_header=>ts}
      end
    end
  end
end
