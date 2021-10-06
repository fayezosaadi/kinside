class Api::V1::ActorsController < ApplicationController
  before_action :find_actor, only: [:show]

  # GET /actors
  def index
    @actors = Actor.all
    render json: @actors, include: [:movies]
  end

  def show
    render json: @actorsList
  end

  private

  def find_actor
    @actorsList = Array.new
    params[:id].split(',').map do |id|
      topCoActors = Hash.new(0)
      @actor = Actor.find_by(:id => id)
      @actorMovies = Movie.find_by_sql("SELECT * FROM movies INNER JOIN actors_movies ON movies.id = actors_movies.movie_id WHERE actors_movies.actor_id IN('#{@actor.id}')")
      @actorMovies.map do |movie|
        ApplicationRecord.table_name = "actors_movies"
        @coActors = ApplicationRecord.find_by_sql("SELECT actor_id from actors_movies WHERE movie_id = '#{movie.id}'")

        @coActors.map do |coActor|
          if coActor.actor_id != @actor.id
            topCoActors[coActor.actor_id] += 1
          end
        end
      end

      @actorDetails = Hash.new(0)
      @actorDetails['id'] = @actor.id
      @actorDetails['first_name'] = @actor.first_name
      @actorDetails['last_name'] = @actor.last_name
      @actorDetails['created_at'] = @actor.created_at
      @topCoActors = Actor.where(:id => topCoActors.sort_by { |_, v| -v }.first(5).map(&:first))
      @actorDetails['co_actors'] = @topCoActors
      @actorDetails['movies'] = @actorMovies
      @actorsList.push(@actorDetails)
    end

  end

end
