# frozen_string_literal: true

class CreateTenants < ActiveRecord::Migration[8.0]
  def change
    create_table :tenants do |t|
      t.uuid :uuid, default: -> { 'gen_random_uuid()' }, null: false, index: { unique: true }
      t.string :name, limit: 40
      t.string :slug, limit: 80
      t.string :ip, limit: 60
      t.string :location
      t.jsonb :lat_lon, default: { lat: 0, lan: 0 }
      t.string :url, null: false,  limit: 40, index: { unique: true }

      t.timestamps
    end
  end
end
