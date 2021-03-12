class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string  :title, null: false
      t.text    :content, null: false
      t.integer :place_id, null: false
      t.integer :floor_id, null: false
      t.integer :style_id, null: false

      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
