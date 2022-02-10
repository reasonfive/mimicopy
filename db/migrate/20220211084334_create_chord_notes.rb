class CreateChordNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :chord_notes do |t|
      t.integer :chord_id
      t.integer :note_id

      t.timestamps
    end
  end
end
