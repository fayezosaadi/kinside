class CreateActors < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :actors, id: :uuid, column_options: { type: :uuid } do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
