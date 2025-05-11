class CreateMemberPackagePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :member_package_payments do |t|
      t.references :member_package, index: true, foreign_key: true
      t.string :payment_status
      t.string :amount_total
      t.string :currency
      t.string :customer_id
      t.string :payment_id
      t.string :customer_email
      t.jsonb :charges

      t.timestamps
    end
  end
end
