class Api::V1::ActorsController < ApplicationController
  before_action :find_actor, only: [:show]

  # GET /actors
  def index
    @actors = Actor.all
    render json: @actors, include: [:movies]
  end

  def show
    render json: @actor, include: [:movies]
  end

  private

  def find_actor
    @actor = Actor.where(:id => params[:id].split(','))
  end

end
