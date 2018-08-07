class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:email])
    render json: { errors: ['There is no such user!'], status: 404 } unless user.present?

    user = user.authenticate(params[:password])
    render json: { errors: ['Wrong password'], status: 401 } unless user

    token = JsonWebToken.encode(user_id: user.id)
    render json: { token: token, status: 201 }
  end
end