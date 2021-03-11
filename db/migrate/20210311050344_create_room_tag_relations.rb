class CreateRoomTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :room_tag_relations do |t|
      t.references :room, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
