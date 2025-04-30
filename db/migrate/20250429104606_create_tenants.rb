class CreateTenants < ActiveRecord::Migration[8.0]
  def change
    create_table :tenants  do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }, null: false
      t.string :name, limit: 40
      t.string :slug, limit: 80
      t.string :ip, limit: 20
      t.string :location
      t.jsonb :lat_lon, default: { lat: 0, lan: 0 }
      t.string :url, limit: 40

      t.timestamps
    end
  end
end
