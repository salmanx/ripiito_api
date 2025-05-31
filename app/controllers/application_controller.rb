# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler
  include JsonWebToken

  before_action :authenticate_user

  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_not_valid_response
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  rescue_from ArgumentError, with: :handle_argument_error
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_duplicate_key_constraint
  rescue_from NoMethodError, with: :handle_no_method_error

  private

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
