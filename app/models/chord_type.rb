class ChordType < ApplicationRecord
    has_many :chords, dependent: :destroy
end
