# frozen_string_literal: true

class CreatePaymentMethodEnum < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE payment_method AS ENUM ('CARD', 'EXTERNAL', 'COD');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE payment_method;
    SQL
  end
end
