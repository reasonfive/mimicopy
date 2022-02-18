class Scale < ApplicationRecord
    belongs_to :scale_type
    has_many :scale_notes, dependent: :destroy
end
