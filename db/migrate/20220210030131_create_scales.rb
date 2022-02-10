class CreateScales < ActiveRecord::Migration[5.2]
  def change
    create_table :scales do |t|
      t.string :constituent_sound
      t.integer :scale_type_id
      t.integer :root_note_id

      t.timestamps
    end
  end
end
