class ApplicationController < ActionController::API
  before_action :authenticate_token!
  before_action :set_request_format

  private

  def authenticate_token!
    token = request.headers.fetch('Authorization', '').split('').last

    payload = JsonWebToken.decode(token)
    @current_user = User.find(payload['user_id'])
    render json: {errors: ['There is no such user!'], status: 404} unless user.present?
  rescue JWT::ExpiredSignature
    render json: {errors: ['Auth token has expired']}, status: :unauthorized
  rescue JWT::DecodeError
    render json: {errors: ['Invalid auth token']}, status: :unauthorized
  end

  def set_request_format
    request.format = :json
  end
end
