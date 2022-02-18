class Chord < ApplicationRecord
    belongs_to :chord_type
    has_many :chord_notes, dependent: :destroy
end
