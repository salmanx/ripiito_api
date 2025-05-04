# frozen_string_literal: true

class CreateEnumForBillingPeriodUnit < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE plan_billing_period_unit AS ENUM ('DAY', 'WEEK', 'MONTH', 'YEAR');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE plan_billing_period_unit;
    SQL
  end
end
