# frozen_string_literal: true

class CreatePlanEnums < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE billing_period_unit AS ENUM ('DAY', 'WEEK', 'MONTH', 'YEAR');
      CREATE TYPE currency_code AS ENUM ('JPY', 'USD', 'EUR');#{'      '}
      CREATE TYPE plan_status AS ENUM ('DRAFT', 'ACTIVE', 'RETIRED');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE plan_status;
      DROP TYPE currency_code;
      DROP TYPE billing_period_unit;
    SQL
  end
end
