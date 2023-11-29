class CreatePoems < ActiveRecord::Migration[7.0]
  def change
    create_table :poems do |t|
      t.string :title
      t.text :poem
      t.integer :user_id

      t.timestamps
    end
  end
end
