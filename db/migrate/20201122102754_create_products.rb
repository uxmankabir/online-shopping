class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :description
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
