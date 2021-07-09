class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    user = User.find_by(email: auth_params[:email].to_s.downcase)

    if user and user.authenticate(auth_params[:password])
      if user.confirmed_at?
        token = JsonWebToken.encode({ user_id: user.id })
        render json: { token: token }, status: :ok
      else
        render json: { errors: ['Email not confirmed.'] }, status: :unauthorized
      end
    else
      render json: { errors: ['Incorrect email or password'] }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.require(:authentication).permit(:email, :password)
  end
end
