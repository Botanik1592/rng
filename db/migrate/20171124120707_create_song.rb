class CreateSong < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :author, null: false
      t.string :track, null: false
      t.string :href, null: false
      t.string :filename, null: false
    end
  end
end
