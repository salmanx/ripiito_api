# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.uuid :uuid, default: -> { 'gen_random_uuid()' }, null: false, index: { unique: true }
      t.string :fullname, limit: 40
      t.string :username, limit: 20
      t.string :email, limit: 40, null: false, index: { unique: true }
      t.string :password, limit: 80
      t.references :tenant, index: true, foreign_key: true

      t.timestamps
    end
  end
end
