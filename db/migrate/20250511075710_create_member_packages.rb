# frozen_string_literal: true

class CreateMemberPackages < ActiveRecord::Migration[8.0]
  def change
    create_table :member_packages do |t|
      t.references :member, index: true, foreign_key: true
      t.references :package, index: true, foreign_key: true
      t.column :payment_method, :payment_method, default: 'CARD', null: false
      t.decimal :purchase_price
      t.decimal :tax_fee
      t.decimal :total_price
      t.boolean :active, default: false

      t.timestamps
    end
    add_index :member_packages, %i[member_id package_id], unique: true
  end
end
