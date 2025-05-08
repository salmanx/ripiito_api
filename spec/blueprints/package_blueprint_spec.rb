# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackageBlueprint do
  let(:package) { create(:package) }
  let(:blueprint) { PackageBlueprint.render(package) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes the correct fields' do
    expect(parsed).to include(
      'name',
      'status',
      'auto_renewable',
      'cancelable',
      'trial_days',
      'max_subscriber',
      'billing_period',
      'billing_period_unit',
      'pricing_type',
      'pricing_model',
      'package_type',
      'exclusive',
      'created_at',
      'updated_at',
    )
  end

  it 'excludes the id field' do
    expect(parsed).not_to have_key('id')
  end
end
