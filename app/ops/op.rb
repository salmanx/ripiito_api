# frozen_string_literal: true

class Op < Subroutine::Op
  def success?
    errors.empty?
  end

  def failure?
    errors.any?
  end
end
