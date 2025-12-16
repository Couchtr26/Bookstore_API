class AuthenticationController < ApplicationController
  def login
    user = User.find_for_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      token = encode_token(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, "your_secret_key")
  end
end
