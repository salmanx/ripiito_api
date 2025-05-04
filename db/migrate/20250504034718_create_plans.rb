# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name, limit: 100, null: false
      t.string :slug, limit: 200
      t.integer :billing_period
      t.column :status, :plan_status, default: 'DRAFT', null: false
      t.column :billing_period_unit, :plan_billing_period_unit, default: 'MONTH', null: false
      t.integer :duration, null: false
      t.boolean :auto_renewable, default: false
      t.boolean :cancelable, default: true
      t.float :base_price, default: 0.0, null: false
      t.integer :trial_days, default: 0
      t.boolean :is_price_visible, default: true
      t.column :currency, :currency_code, default: 'JPY', null: false
      t.integer :max_subscriber
      t.boolean :taxable, default: false
      t.float :tax_fee, default: 0.0
      t.jsonb :geo_availability
      t.jsonb :metadata
      t.boolean :exclusive, default: true
      t.references :tenant, index: true, foreign_key: true

      t.timestamps
    end
    add_index :plans, %i[tenant_id slug], unique: true
  end
end
