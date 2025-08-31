class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    secret = ENV['STRIPE_WEBHOOK_SECRET']

    event = nil
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, secret) if secret.present?
      event ||= JSON.parse(payload)
    rescue JSON::ParserError
      return render json:{error:'invalid payload'}, status:400
    rescue Stripe::SignatureVerificationError
      return render json:{error:'invalid signature'}, status:400
    end

    type = (event['type'] || event.dig(:type)).to_s
    data = event['data'] && (event['data']['object'] || event['data'][:object])

    case type
    when 'payment_intent.succeeded'
      if fi = FundingIntent.find_by(provider_ref: data['id'])
        fi.update!(status:'succeeded'); Metrics.inc(:funding_cleared)
      end
      if (data['metadata']||{})['settlement_ref'] && (s = Settlement.find_by(transfer_id: (data['metadata']||{})['settlement_ref']))
        s.update!(funding_status:'cleared'); Metrics.inc(:fx_trades_started)
        FxSettlementWorker.perform_async(s.transfer_id, s.meta)
      end
    when 'payment_intent.payment_failed'
      if fi = FundingIntent.find_by(provider_ref: data['id'])
        fi.update!(status:'failed')
      end
    end

    render json:{ok:true}
  end
end
