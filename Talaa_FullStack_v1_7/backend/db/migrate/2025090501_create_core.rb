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

    create_table :user_kycs do |t|
      t.bigint :user_id
      t.string :full_name
      t.string :id_type
      t.string :id_number
      t.integer :status, default: 0
      t.jsonb :document_refs, default: []
      t.timestamps
    end

    create_table :admin_users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string   :remember_token
      t.datetime :remember_created_at
      t.timestamps null: false
      t.index :email, unique: true
    end
  end
end
