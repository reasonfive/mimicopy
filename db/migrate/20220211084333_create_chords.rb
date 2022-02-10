class CreateChords < ActiveRecord::Migration[5.2]
  def change
    create_table :chords do |t|
      t.string :constituent_sound
      t.integer :chord_type_id
      t.integer :root_note_id

      t.timestamps
    end
  end
end
