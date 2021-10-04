class Api::V1::ActorsController < ApplicationController
  # GET /actors
  def index
    @actors = Actor.all
    render json: @actors
  end

end
