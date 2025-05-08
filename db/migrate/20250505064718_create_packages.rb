# frozen_string_literal: true

class CreatePackages < ActiveRecord::Migration[8.0]
  def change
    create_table :packages do |t|
      t.string :name, limit: 100, null: false
      t.string :slug, limit: 200
      t.integer :billing_period
      t.boolean :auto_renewable, default: false
      t.boolean :cancelable, default: true
      t.integer :trial_days, default: 0
      t.integer :max_subscribe
      t.jsonb :geo_availability
      t.jsonb :metadata
      t.boolean :exclusive, default: true
      t.column :status, :package_status, default: 'DRAFT', null: false
      t.column :billing_period_unit, :billing_period_unit, default: 'MONTH', null: false
      t.column :pricing_type, :pricing_type, default: 'RECURRING', null: false
      t.column :pricing_model, :pricing_model, default: 'FIXED', null: false
      t.column :package_type, :package_type, default: 'REQUIRED', null: false

      t.references :plan, index: true, foreign_key: true
      t.bigint :created_by

      t.timestamps
    end
    add_index :packages, %i[plan_id slug], unique: true
  end
end
