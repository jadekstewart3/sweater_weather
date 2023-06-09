class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else 
      render json: ErrorSerializer.new(user).user_error, status: 401
    end
  end

  def login
		user = User.find_by(email: user_params[:email])
		if user && user.authenticate(user_params[:password])
			render json: UserSerializer.new(user), status: 201
		elsif user && user_params[:uid] == user.uid
			render json: UserSerializer.new(user), status: 201
		else
			render json: ErrorSerializer.failed_auth, status: 401
		end
	end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end