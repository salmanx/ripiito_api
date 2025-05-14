# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenantBlueprint do
  let(:tenant) { create(:tenant) }
  let(:blueprint) { TenantBlueprint.render(tenant) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes the correct fields' do
    expect(parsed).to include('id', 'name', 'ip', 'location', 'url', 'created_at')
  end
end
