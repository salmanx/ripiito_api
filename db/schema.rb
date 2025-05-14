# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_11_081613) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "billing_period_unit", ["DAY", "WEEK", "MONTH", "YEAR"]
  create_enum "currency_code", ["JPY", "USD", "EUR"]
  create_enum "package_status", ["DRAFT", "ACTIVE", "RETIRED"]
  create_enum "package_type", ["REQUIRED", "OPTIONAL", "ADDON"]
  create_enum "payment_method", ["CARD", "EXTERNAL", "COD"]
  create_enum "plan_status", ["DRAFT", "ACTIVE", "RETIRED"]
  create_enum "pricing_model", ["FIXED", "TIRED", "VOLUME"]
  create_enum "pricing_type", ["ONE_TIME", "RECURRING", "USAGE"]
  create_enum "product_type", ["PHYSICAL", "SERVICE", "DIGITAL"]

  create_table "member_package_payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "member_package_id"
    t.string "payment_status"
    t.string "amount_total"
    t.string "currency"
    t.string "customer_id"
    t.string "payment_id"
    t.string "customer_email"
    t.jsonb "charges"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_package_id"], name: "index_member_package_payments_on_member_package_id"
  end

  create_table "member_package_purchases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "member_package_id"
    t.uuid "member_package_payment_id"
    t.datetime "payment_date"
    t.datetime "next_payment_date"
    t.integer "billing_cycle"
    t.integer "current_billing_cycle"
    t.boolean "is_external_paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_package_id"], name: "index_member_package_purchases_on_member_package_id"
    t.index ["member_package_payment_id"], name: "index_member_package_purchases_on_member_package_payment_id"
  end

  create_table "member_packages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "member_id"
    t.uuid "package_id"
    t.enum "payment_method", default: "CARD", null: false, enum_type: "payment_method"
    t.decimal "purchase_price"
    t.decimal "tax_fee"
    t.decimal "total_price"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id", "package_id"], name: "index_member_packages_on_member_id_and_package_id", unique: true
    t.index ["member_id"], name: "index_member_packages_on_member_id"
    t.index ["package_id"], name: "index_member_packages_on_package_id"
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "fullname", limit: 40
    t.string "username", limit: 20
    t.string "email", limit: 40, null: false
    t.string "password", limit: 80
    t.uuid "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["tenant_id"], name: "index_members_on_tenant_id"
  end

  create_table "package_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "price", null: false
    t.boolean "is_price_visible", default: true
    t.boolean "taxable", default: false
    t.decimal "tax_fee"
    t.datetime "effective_from", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "effective_to"
    t.uuid "package_id"
    t.bigint "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_package_prices_on_package_id"
  end

  create_table "packages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "slug", limit: 200, null: false
    t.integer "billing_period"
    t.boolean "auto_renewable", default: false
    t.boolean "cancelable", default: true
    t.integer "trial_days", default: 0
    t.integer "max_subscribe"
    t.jsonb "geo_availability"
    t.jsonb "metadata"
    t.boolean "exclusive", default: true
    t.enum "status", default: "DRAFT", null: false, enum_type: "package_status"
    t.enum "billing_period_unit", default: "MONTH", null: false, enum_type: "billing_period_unit"
    t.enum "pricing_type", default: "RECURRING", null: false, enum_type: "pricing_type"
    t.enum "pricing_model", default: "FIXED", null: false, enum_type: "pricing_model"
    t.enum "package_type", default: "REQUIRED", null: false, enum_type: "package_type"
    t.uuid "plan_id"
    t.bigint "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id", "slug"], name: "index_packages_on_plan_id_and_slug", unique: true
    t.index ["plan_id"], name: "index_packages_on_plan_id"
    t.index ["slug"], name: "index_packages_on_slug", unique: true
  end

  create_table "plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "slug", limit: 200, null: false
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
    t.uuid "tenant_id"
    t.bigint "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_plans_on_slug", unique: true
    t.index ["tenant_id", "slug"], name: "index_plans_on_tenant_id_and_slug", unique: true
    t.index ["tenant_id"], name: "index_plans_on_tenant_id"
  end

  create_table "tenant_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.uuid "tenant_id"
    t.text "description"
    t.bigint "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tenant_settings_on_tenant_id"
  end

  create_table "tenants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 40
    t.string "ip", limit: 60
    t.string "location"
    t.jsonb "lat_lon", default: {"lan" => 0, "lat" => 0}
    t.string "url", limit: 60, null: false
    t.bigint "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_tenants_on_url", unique: true
  end

  add_foreign_key "member_package_payments", "member_packages"
  add_foreign_key "member_package_purchases", "member_package_payments"
  add_foreign_key "member_package_purchases", "member_packages"
  add_foreign_key "member_packages", "members"
  add_foreign_key "member_packages", "packages"
  add_foreign_key "members", "tenants"
  add_foreign_key "package_prices", "packages"
  add_foreign_key "packages", "plans"
  add_foreign_key "plans", "tenants"
  add_foreign_key "tenant_settings", "tenants"
end
