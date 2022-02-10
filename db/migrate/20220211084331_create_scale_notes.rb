class CreateScaleNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :scale_notes do |t|
      t.integer :scale_id
      t.integer :note_id

      t.timestamps
    end
  end
end
