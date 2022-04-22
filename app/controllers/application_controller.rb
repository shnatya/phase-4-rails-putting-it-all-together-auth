class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  private

  def invalid_record(invalid)
      render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity #422
  end
end
