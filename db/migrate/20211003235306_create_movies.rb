class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies, id: :uuid, column_options: { type: :uuid } do |t|
      t.string :title
      t.string :year
      t.string :runtime
      t.string :director
      t.string :plot
      t.string :posterUrl
      t.float :rating
      t.string :pageUrl
      t.string :genres, array: true, default: []

      t.timestamps
    end
  end
end
