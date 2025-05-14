# frozen_string_literal: true

class CreateMemberPackages < ActiveRecord::Migration[8.0]
  def change
    create_table :member_packages, id: :uuid do |t|
      t.references :member, type: :uuid, index: true, foreign_key: true
      t.references :package, type: :uuid, index: true, foreign_key: true
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
