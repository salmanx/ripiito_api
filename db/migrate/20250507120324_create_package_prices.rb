# frozen_string_literal: true

class CreatePackagePrices < ActiveRecord::Migration[8.0]
  def change
    create_table :package_prices do |t|
      t.decimal :price, null: false
      t.boolean :is_price_visible, default: true
      t.boolean :taxable, default: false
      t.decimal :tax_fee
      t.datetime :effective_from, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :effective_to
      t.references :package, index: true, foreign_key: true
      t.bigint :created_by
      t.timestamps
    end
  end
end
