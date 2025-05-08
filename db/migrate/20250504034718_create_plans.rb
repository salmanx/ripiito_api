# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name, limit: 100, null: false
      t.string :slug, limit: 200
      t.integer :duration, null: false
      t.boolean :auto_renewable, default: false
      t.boolean :cancelable, default: true
      t.integer :trial_days, default: 0
      t.column :currency, :currency_code, default: 'JPY', null: false
      t.integer :max_subscriber
      t.jsonb :geo_availability
      t.jsonb :metadata
      t.boolean :exclusive, default: true
      t.column :status, :plan_status, default: 'DRAFT', null: false
      t.references :tenant, index: true, foreign_key: true
      t.bigint :created_by

      t.timestamps
    end
    add_index :plans, %i[tenant_id slug], unique: true
  end
end
