class CreateFavequotes < ActiveRecord::Migration
  def change
    create_table :favequotes do |t|
    	t.string :quotation
    	t.integer :book_id
    	t.integer :user_id

      t.timestamps null: false
    end
  end
end
