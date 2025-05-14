# frozen_string_literal: true

class CreateMemberPackagePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :member_package_purchases, id: :uuid do |t|
      t.references :member_package, type: :uuid, index: true, foreign_key: true
      t.references :member_package_payment, type: :uuid, null: true, foreign_key: true # null => true if external payment
      t.datetime :payment_date
      t.datetime :next_payment_date, null: true # null true => if in last billing cycle
      t.integer :billing_cycle
      t.integer :current_billing_cycle
      t.boolean :is_external_paid, default: false
      # t.integer :invoice_id
      t.timestamps
    end
  end
end
