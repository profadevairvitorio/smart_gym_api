class Api::V1::GymsController < ApplicationController
  before_action :set_gym, only: [:show, :update, :destroy]

  def index
    @gyms = Gym.all
    render json: @gyms
  end

  def show
    render json: @gym
  end

  def create
    @gym = Gym.new(gym_params)
    if @gym.save
      render json: @gym, status: :created
    else
      render json: @gym.errors, status: :unprocessable_entity
    end
  end

  def update
    if @gym.update(gym_params)
      render json: @gym
    else
      render json: @gym.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @gym.destroy
    head :no_content
  end

  private

  def set_gym
    @gym = Gym.find(params[:id])
  end

  def gym_params
    params.require(:gym).permit(:name, :document_number, :document_type, :email)
  end
end
