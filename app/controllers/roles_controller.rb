class RolesController < ApplicationController
  before_action :set_role, only: %i[show update destroy]

  # GET /roles
  def index
    roles = Role.all

    render json: { data: roles }, status: :ok
  end

  # GET /roles/:id
  def show
    render json: { data: @role }, status: :ok
  end

  # POST /roles
  def create
    role = Role.new(role_params)

    if role.save
      render json: { data: role }, status: :created
    else
      render json: role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roles/:id
  def update
    if @role.update(role_params)
      render json: { data: @role }, status: :accepted
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /roles/:id
  def destroy
    @role.destroy

    render json: { data: @role }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:name)
  end
end
