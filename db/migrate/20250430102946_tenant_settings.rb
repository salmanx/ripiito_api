# frozen_string_literal: true

class TenantSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :tenant_settings do |t|
      t.string :logo_url, null: true
      t.string :favicon_url, null: true
      t.string :text_color, null: true, limit: 25
      t.string :title_color, null: true, limit: 25
      t.string :button_background_color, null: true, limit: 25
      t.string :button_text_color, null: true, limit: 25
      t.string :html_head_title, null: true
      t.string :meta_application_name, null: true, limit: 40
      t.string :meta_author, null: true, limit: 20
      t.string :meta_description, null: true, limit: 100
      t.string :meta_keywords, null: true, limit: 100
      t.references :tenant, index: true, foreign_key: true
      t.text :description, null: true

      t.timestamps
    end
  end
end
