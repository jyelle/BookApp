class CreateLityears < ActiveRecord::Migration
  def change
    create_table :lityears do |t|
    	t.integer :year_read
    	t.integer :book_id
    	t.integer :user_id

      t.timestamps null: false
    end
  end
end
