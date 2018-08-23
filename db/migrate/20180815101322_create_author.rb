class CreateAuthor < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.string :search_name, null: false
    end

    File.open(Rails.root.join('public', 'Authors.csv'), "r").each_line do |line|
      data = line.split(';')
      Author.create!(first_name: data[2].downcase, last_name: data[1].downcase, middle_name: data[3].downcase, search_name: data[4].downcase)
    end
  end
end
