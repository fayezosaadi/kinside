require 'rest-client'

class Api::V1::ModelsController < ApplicationController

  # populate database
  def create
    populate_actors()
    populate_movies()

    puts "seeding done"
  end

  private

  def populate_actors
    response = RestClient.get 'https://0zrzc6qbtj.execute-api.us-east-1.amazonaws.com/kinside/actors'
    json = JSON.parse response

    if !json.nil?

      json.map do |actor|
        Actor.create(id: actor["id"], first_name: actor["first_name"], last_name: actor["last_name"])
      end

      # Todo: verify the data of these actors
      Actor.create(id: 'e58036e3-6a0f-4c7c-8c41-af3aad2a7b88', first_name: 'unknown', last_name: 'unknown')
      Actor.create(id: 'c798efa3-cc22-4ef6-acc7-0b614c1ede20', first_name: 'unknown', last_name: 'unknown')
    end
  end

  def populate_movies
    response = RestClient.get 'https://0zrzc6qbtj.execute-api.us-east-1.amazonaws.com/kinside/movies'
    json = JSON.parse response

    if !json.nil?

      json.map do |movie|
        @movieId = SecureRandom.uuid

        @movieCreated = Movie.create(
          id: @movieId,
          title: movie["title"],
          year: movie["year"],
          runtime: movie["runtime"],
          genres: movie["genres"],
          director: movie["director"],
          plot: movie["plot"],
          posterUrl: movie["posterUrl"],
          rating: movie["rating"],
          pageUrl: movie["pageUrl"],
        )

        @movieCreated.actor_ids = movie['actorIds']
        @movieCreated.save!
      end
    end
  end

end
