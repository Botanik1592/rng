class CreateBook < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.belongs_to :author, index: true
      t.string :filename, null: false
      t.string :title, null: false
    end

    file2 = File.read(Rails.root.join('public', 'Author_List.json'))
    data2 = JSON.parse(file2)

    File.open(Rails.root.join('public', 'Books.csv'), "r").each_line do |line|
      data = line.split(';')
      author_id = data2.detect{|aaa| aaa["BookID"] == data[0]}['AuthorID'].to_i
      Book.create!(filename: data[9]+data[11], title: data[2].downcase, author_id: author_id)
    end
  end
end
