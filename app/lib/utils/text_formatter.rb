# frozen_string_literal: true

module Utils
  class TextFormatter
    def self.sentence_case(str)
      str.to_s.downcase.sub(/\A\w/, &:upcase)
    end

    def self.clean_humanized_title(attribute_path)
      sentence_case attribute_path.to_s.tr('.', ' ').humanize.titleize
    end
  end
end
