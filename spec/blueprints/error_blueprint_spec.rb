# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorBlueprint do
  let(:errors) do
    ActiveModel::Errors.new(nil).tap do |e|
      e.add(:name, "name can't be blank")
      e.add(:name, 'name is too short (minimum is 2 characters)')
    end
  end

  let(:error_object) { { status: 409, errors: errors } }
  let(:blueprint) { ErrorBlueprint.render(error_object) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes status and formatted errors' do
    expect(parsed).to include('status', 'errors')
    expect(parsed['status']).to eq(409)
    # make sure always return first error from the errors array for particular error
    expect(parsed['errors']['name']).to eq(["name can't be blank"])
    expect(parsed['errors']['name']).not_to eq(['name is too short (minimum is 2 characters)'])
  end
end
