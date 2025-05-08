# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Utils::TextFormatter do
  describe 'sentence_case' do
    it 'capitalizes the first letter and downcases the rest' do
      expect(described_class.sentence_case('HELLO world')).to eq('Hello world')
    end

    it 'returns an empty string if input is nil' do
      expect(described_class.sentence_case(nil)).to eq('')
    end

    it 'works with numeric strings' do
      expect(described_class.sentence_case('123abc')).to eq('123abc')
    end
  end

  describe 'clean_humanized_title' do
    it 'replaces dots with spaces and formats to sentence case' do
      expect(described_class.clean_humanized_title('package_price.effective_to'))
        .to eq('Package price effective to')
    end

    it 'handles single words correctly' do
      expect(described_class.clean_humanized_title('name')).to eq('Name')
    end

    it 'handles nil input gracefully' do
      expect(described_class.clean_humanized_title(nil)).to eq('')
    end
  end
end
