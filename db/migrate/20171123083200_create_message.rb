class CreateMessage < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string  :zapros, null: false
      t.string  :href,   null: false
      t.jsonb   :data, null: false
      t.integer :user_id
      t.integer :chat_id
      t.string  :username
      t.string  :first_name
      t.string  :last_name
      t.string  :text

      t.timestamps
    end
  end
end
