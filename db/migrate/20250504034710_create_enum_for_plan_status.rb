# frozen_string_literal: true

class CreateEnumForPlanStatus < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE plan_status AS ENUM ('DRAFT', 'ACTIVE', 'RETIRED');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE plan_status;
    SQL
  end
end
