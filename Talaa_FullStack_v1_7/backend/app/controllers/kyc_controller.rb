class KycController < ApplicationController
  def start
    k = UserKyc.create!(user_id: current_user_id, full_name: params[:full_name], id_type: params[:id_type], id_number: params[:id_number], status: :pending)
    render json: { kyc_id: k.id, status: k.status }
  end

  def upload
    k = UserKyc.find(params[:kyc_id])
    refs = k.document_refs || []
    refs << { kind: params[:kind], ref: params[:ref] }
    k.update!(document_refs: refs)
    render json: { ok: true, refs: k.document_refs }
  end

  def submit
    k = UserKyc.find(params[:kyc_id])
    k.update!(status: :pending)
    render json: { ok: true, status: k.status }
  end
end
