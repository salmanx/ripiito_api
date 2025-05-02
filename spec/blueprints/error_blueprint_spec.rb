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
    # make sure always return first error from the errors array for particular error
    expect(parsed['errors']['name']).to eq(["can't be blank"])
    expect(parsed['errors']['name']).not_to eq(['is too short (minimum is 2 characters)'])
  end
end
