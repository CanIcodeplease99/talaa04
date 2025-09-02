class Admin::SummaryController < ActionController::API
  def index
    render json: {
      tps: Settlement.where('created_at >= ?', 1.hour.ago).count,
      holds: Settlement.where(status: 'pending_review').count,
      fails: Settlement.where(status: 'failed').count,
      kyb_pending: BusinessProfile.where(status: :pending).count
    }
  end
end
