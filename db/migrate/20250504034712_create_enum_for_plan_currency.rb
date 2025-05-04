# frozen_string_literal: true

class CreateEnumForPlanCurrency < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE currency_code AS ENUM ('JPY', 'USD', 'EUR');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE currency_code;
    SQL
  end
end
