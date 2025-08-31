class CreateCore < ActiveRecord::Migration[7.1]
  def change
    create_table :settlements do |t|
      t.string  :transfer_id
      t.bigint  :from_user
      t.bigint  :to_user
      t.bigint  :amount_cents
      t.string  :currency
      t.string  :rail
      t.string  :status, default: 'queued'
      t.integer :attempts, default: 0
      t.string  :last_error
      t.string  :funding_source, default: 'stripe'
      t.string  :funding_status, default: 'pending'
      t.jsonb   :meta, default: {}
      t.timestamps
      t.index :transfer_id, unique: true
    end

    create_table :funding_intents do |t|
      t.string  :provider
      t.string  :provider_ref
      t.string  :client_secret
      t.integer :amount_cents
      t.string  :currency
      t.string  :status, default: 'requires_confirmation'
      t.bigint  :settlement_id
      t.timestamps
      t.index :provider_ref
    end
  end
end
