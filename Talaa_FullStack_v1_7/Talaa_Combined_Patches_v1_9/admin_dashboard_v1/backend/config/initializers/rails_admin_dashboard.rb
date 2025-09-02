RailsAdmin.config do |config|
  # Models visible
  config.included_models |= %w[Settlement FundingIntent FraudEvent UserKyc BusinessProfile ExternalAccount BankCredit AdminUser]

  # Navigation groups
  config.model 'Settlement' do
    navigation_label 'Payments'
    list do
      field :transfer_id; field :from_user; field :to_user
      field :amount_cents; field :currency
      field :rail; field :status; field :risk_score; field :risk_state
      field :created_at
    end
    show do
      include_all_fields
    end
  end

  config.model 'FraudEvent' do
    navigation_label 'Risk'
    list do
      field :user_id; field :kind; field :payload; field :created_at
    end
  end

  config.model 'BusinessProfile' do
    navigation_label 'Accounts'
    list do
      field :user_id; field :legal_name; field :registration_number; field :industry
      field :status; field :created_at
    end
  end

  config.model 'UserKyc' do
    navigation_label 'Accounts'
    list do
      field :user_id; field :full_name; field :id_type; field :id_number; field :status; field :created_at
    end
  end

  config.model 'ExternalAccount' do
    navigation_label 'Banking'
    list do
      field :user_id; field :provider; field :external_id; field :account_mask; field :currency; field :created_at
    end
  end

  config.model 'BankCredit' do
    navigation_label 'Banking'
    list do
      field :user_id; field :external_ref; field :direction; field :status; field :amount_cents; field :currency; field :created_at
    end
  end

  # Custom actions
  module RailsAdmin
    module Config
      module Actions
        class ReleaseHold < RailsAdmin::Config::Actions::Base
          register_instance_option :member do true end
          register_instance_option :only do ['Settlement'] end
          register_instance_option :controller do
            Proc.new do
              obj = @object
              obj.update!(status: 'queued', risk_state: 'allow', hold_until: nil)
              ::SettlementWorker.perform_async(obj.transfer_id)
              flash[:success] = "Released and queued for send"
              redirect_to back_or_index
            end
          end
          register_instance_option :link_icon do 'icon-ok' end
        end

        class ReverseSettlement < RailsAdmin::Config::Actions::Base
          register_instance_option :member do true end
          register_instance_option :only do ['Settlement'] end
          register_instance_option :controller do
            Proc.new do
              obj = @object
              ::Settlement.create!(transfer_id: "rev_#{SecureRandom.hex(6)}", from_user: obj.to_user, to_user: obj.from_user,
                                   amount_cents: obj.amount_cents, currency: obj.currency, rail: 'admin_reverse', status: 'sent',
                                   meta: { reason: 'admin_reverse', original: obj.transfer_id })
              flash[:success] = "Reversal created"
              redirect_to back_or_index
            end
          end
          register_instance_option :link_icon do 'icon-repeat' end
        end

        class ApproveBusiness < RailsAdmin::Config::Actions::Base
          register_instance_option :member do true end
          register_instance_option :only do ['BusinessProfile'] end
          register_instance_option :controller do
            Proc.new do
              @object.update!(status: :approved)
              flash[:success] = "Business approved"
              redirect_to back_or_index
            end
          end
          register_instance_option :link_icon do 'icon-ok' end
        end

        class RejectBusiness < RailsAdmin::Config::Actions::Base
          register_instance_option :member do true end
          register_instance_option :only do ['BusinessProfile'] end
          register_instance_option :controller do
            Proc.new do
              @object.update!(status: :rejected)
              flash[:error] = "Business rejected"
              redirect_to back_or_index
            end
          end
          register_instance_option :link_icon do 'icon-remove' end
        end
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    show
    edit
    delete
    RailsAdmin::Config::Actions::ReleaseHold
    RailsAdmin::Config::Actions::ReverseSettlement
    RailsAdmin::Config::Actions::ApproveBusiness
    RailsAdmin::Config::Actions::RejectBusiness
  end
end
