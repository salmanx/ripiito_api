ActiveRecord::Schema[8.0].define(version: 2025_05_05_064718) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "billing_period_unit", ["DAY", "WEEK", "MONTH", "YEAR"]
  create_enum "currency_code", ["JPY", "USD", "EUR"]
  create_enum "package_status", ["DRAFT", "ACTIVE", "RETIRED"]
  create_enum "package_type", ["REQUIRED", "OPTIONAL", "ADDON"]
  create_enum "plan_status", ["DRAFT", "ACTIVE", "RETIRED"]
  create_enum "pricing_model", ["FIXED", "TIRED", "VOLUME"]
  create_enum "pricing_type", ["ONE_TIME", "RECURRING", "USAGE"]
  create_enum "product_type", ["PHYSICAL", "SERVICE", "DIGITAL"]

  create_table "packages", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "slug", limit: 200
    t.integer "billing_period"
    t.boolean "auto_renewable", default: false
    t.boolean "cancelable", default: true
    t.float "base_price", default: 0.0, null: false
    t.integer "trial_days", default: 0
    t.boolean "is_price_visible", default: true
    t.integer "max_subscriber"
    t.boolean "taxable", default: false
    t.float "tax_fee", default: 0.0
    t.jsonb "geo_availability"
    t.jsonb "metadata"
    t.boolean "exclusive", default: true
    t.enum "status", default: "DRAFT", null: false, enum_type: "package_status"
    t.enum "billing_period_unit", default: "MONTH", null: false, enum_type: "billing_period_unit"
    t.enum "pricing_type", default: "RECURRING", null: false, enum_type: "pricing_type"
    t.enum "pricing_model", default: "FIXED", null: false, enum_type: "pricing_model"
    t.enum "package_type", default: "REQUIRED", null: false, enum_type: "package_type"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id", "slug"], name: "index_packages_on_plan_id_and_slug", unique: true
    t.index ["plan_id"], name: "index_packages_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "slug", limit: 200
    t.integer "duration", null: false
    t.boolean "auto_renewable", default: false
    t.boolean "cancelable", default: true
    t.integer "trial_days", default: 0
    t.enum "currency", default: "JPY", null: false, enum_type: "currency_code"
    t.integer "max_subscriber"
    t.jsonb "geo_availability"
    t.jsonb "metadata"
    t.boolean "exclusive", default: true
    t.enum "status", default: "DRAFT", null: false, enum_type: "plan_status"
    t.bigint "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id", "slug"], name: "index_plans_on_tenant_id_and_slug", unique: true
    t.index ["tenant_id"], name: "index_plans_on_tenant_id"
  end

  create_table "tenant_settings", force: :cascade do |t|
    t.string "logo_url"
    t.string "favicon_url"
    t.string "text_color", limit: 25
    t.string "title_color", limit: 25
    t.string "button_background_color", limit: 25
    t.string "button_text_color", limit: 25
    t.string "html_head_title"
    t.string "meta_application_name", limit: 40
    t.string "meta_author", limit: 20
    t.string "meta_description", limit: 100
    t.string "meta_keywords", limit: 100
    t.bigint "tenant_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tenant_settings_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", limit: 40
    t.string "slug", limit: 80
    t.string "ip", limit: 60
    t.string "location"
    t.jsonb "lat_lon", default: {"lan" => 0, "lat" => 0}
    t.string "url", limit: 60, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_tenants_on_url", unique: true
    t.index ["uuid"], name: "index_tenants_on_uuid", unique: true
  end

  add_foreign_key "packages", "plans"
  add_foreign_key "plans", "tenants"
  add_foreign_key "tenant_settings", "tenants"
end
