class CreateChordTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :chord_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
