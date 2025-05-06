# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlanBlueprint do
  let(:plan) { create(:plan) }
  let(:blueprint) { PlanBlueprint.render(plan) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes the correct fields' do
    expect(parsed).to include(
      'name', 'status', 'slug', 'duration', 'auto_renewable', 'cancelable', 'trial_days',
      'currency', 'max_subscriber', 'exclusive', 'created_at', 'updated_at'
    )
  end

  it 'excludes the id field' do
    expect(parsed).not_to have_key('id')
  end
end
