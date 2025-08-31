class PaymentsController < ApplicationController
  def transfer
    amount_cents=(params[:amount].to_f*100).to_i
    s=Settlement.create!(transfer_id:"tr_#{SecureRandom.hex(6)}", from_user:current_user_id, to_user:1002,
      amount_cents:amount_cents, currency:"GHS", rail:"gh_domestic", status:"queued",
      meta:{msisdn:"+233555000111", network:"MTN", speed:(params[:speed]=='instant'?'instant':'standard')})
    Metrics.inc(:transfers_created)
    SettlementWorker.perform_async(s.transfer_id)
    render json:{id:s.transfer_id,status:'sent', speed:s.meta['speed']}, status: :created
  end

  def transfer_international
    src=(params[:source_currency]||'USD').upcase; amt=params[:amount].to_f
    rate=(params[:rate]||14.5).to_f; fee=(params[:fee]||(amt*0.01)).to_f
    received=((amt-fee)*rate).round(2); rcents=(received*100).to_i
    s=Settlement.create!(transfer_id:"tr_intl_#{SecureRandom.hex(6)}", from_user:current_user_id, to_user:1002,
      amount_cents:rcents, currency:"GHS", rail:"fx_partner", status:"queued",
      funding_source:"stripe", funding_status:"pending",
      meta:{src_currency:src, src_amount:amt, rate:rate, fee:fee, provider: ENV.fetch('FX_PROVIDER','wise'), msisdn:'+233555000111', network:'MTN'})
    Metrics.inc(:transfers_created)

    fi = FundingIntent.create!(settlement_id: s.id, provider: 'stripe', currency: src.downcase, amount_cents: (amt*100).to_i, status: 'requires_confirmation')
    pi = FundingStripe.create_intent(amount_cents: fi.amount_cents, currency: fi.currency, settlement_ref: s.transfer_id)
    fi.update!(provider_ref: pi[:id], client_secret: pi[:client_secret], status: 'requires_action')

    render json:{id:s.transfer_id, status:'requires_action', received_ghs:received, client_secret: fi.client_secret, funding_intent_id: fi.id}, status: :created
  end
end
