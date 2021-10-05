class CreateMoviesActorsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table(:movies, :actors, { column_options: { type: :uuid } })
  end
end
