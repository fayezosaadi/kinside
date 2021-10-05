class Api::V1::MoviesController < ApplicationController
  before_action :find_movie, only: [:show]

  # GET /movies
  def index
    @movies = Movie.all
    render json: @movies, include: [:actors]
  end

  def show
    render json: @movie, include: [:actors]
  end

  private

  def find_movie
    @movie = Movie.where(:id => params[:id].split(','))
  end

end
