class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else 
      render json: ErrorSerializer.new(user).user_error, status: 404
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end