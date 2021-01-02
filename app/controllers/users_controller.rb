class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    users = User.all

    render json: { data: users }, status: :ok
  end

  # GET /users/:id
  def show
    render json: { data: @user }, status: :ok
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.save
      render json: { data: user }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      render json: { data: @user }, status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy

    render json: { data: @user }, status: :ok
  end

  # POST /users/confirm/:token
  def confirm
    token = params[:token].to_s
    user = User.find_by(confirmation_token: token)

    if user.present? && user.confirmation_token_valid?
      user.mark_as_confirmed!
      render json: { data: user }, status: :accepted
    else
      render json: user.errors, status: :not_acceptable
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
