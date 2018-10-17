class AddCounterToBook < ActiveRecord::Migration[5.0]
  def self.up
    add_column :books, :d_count, :integer, default: 0, null: false
  end

  def self.down
    remove_column :books, :d_count
  end
end
