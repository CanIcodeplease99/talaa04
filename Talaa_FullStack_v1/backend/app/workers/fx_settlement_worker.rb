class FxSettlementWorker; include Sidekiq::Worker; def perform(transfer_id, meta); s=Settlement.find_by(transfer_id:transfer_id); return unless s; s.update!(funding_status:'cleared'); end; end
