class ScaleType < ApplicationRecord
    has_many :scales, dependent: :destroy
end
