# frozen_string_literal: true

ActiveRecord::Schema[8.0].define(version: 20_250_430_102_946) do
  create_schema 'my_crypto'

  # These are extensions that must be enabled in order to support this database
  enable_extension 'pg_catalog.plpgsql'
  enable_extension 'pgcrypto'

  create_table 'tenant_settings', force: :cascade do |t|
    t.string 'logo_url'
    t.string 'favicon_url'
    t.string 'text_color', limit: 25
    t.string 'title_color', limit: 25
    t.string 'button_background_color', limit: 25
    t.string 'button_text_color', limit: 25
    t.string 'html_head_title'
    t.string 'meta_application_name', limit: 40
    t.string 'meta_author', limit: 20
    t.string 'meta_description', limit: 100
    t.string 'meta_keywords', limit: 100
    t.bigint 'tenants_id'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['tenants_id'], name: 'index_tenant_settings_on_tenants_id'
  end

  create_table 'tenants', force: :cascade do |t|
    t.uuid 'uuid', default: -> { 'gen_random_uuid()' }, null: false
    t.string 'name', limit: 40
    t.string 'slug', limit: 80
    t.string 'ip', limit: 20
    t.string 'location'
    t.jsonb 'lat_lon', default: { 'lan' => 0, 'lat' => 0 }
    t.string 'url', limit: 40
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
