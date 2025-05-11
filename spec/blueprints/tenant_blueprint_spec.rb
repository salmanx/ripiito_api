# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TenantBlueprint do
  let(:tenant) { create(:tenant) }
  let(:blueprint) { TenantBlueprint.render(tenant) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes the correct fields' do
    expect(parsed).to include('uuid', 'name', 'ip', 'location', 'url', 'created_at')
  end

  it 'excludes the id field' do
    expect(parsed).not_to have_key('id')
  end

  it 'uses uuid as identifier' do
    expect(parsed['uuid']).to eq(tenant.uuid)
  end
end
