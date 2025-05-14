# frozen_string_literal: true

class CreateTenants < ActiveRecord::Migration[8.0]
  def change
    create_table :tenants, id: :uuid do |t|
      t.string :name, limit: 40
      t.string :ip, limit: 60
      t.string :location
      t.jsonb :lat_lon, default: { lat: 0, lan: 0 }
      t.string :url, null: false,  limit: 60, index: { unique: true }
      t.bigint :created_by

      t.timestamps
    end
  end
end
