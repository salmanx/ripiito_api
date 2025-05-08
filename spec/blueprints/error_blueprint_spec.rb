# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorBlueprint do
  let(:errors) do
    ActiveModel::Errors.new(nil).tap do |e|
      e.add(:name, "can't be blank")
      e.add(:name, 'is too short (minimum is 2 characters)')
    end
  end

  let(:error_object) { { status: 409, errors: errors } }
  let(:blueprint) { ErrorBlueprint.render(error_object) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes status and formatted errors' do
    expect(parsed).to include('status', 'errors')
    expect(parsed['status']).to eq(409)
    expect(parsed['errors']['name']).to eq(["Name can't be blank", 'Name is too short (minimum is 2 characters)'])
  end
end
