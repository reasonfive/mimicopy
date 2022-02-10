FactoryBot.define do
  factory :chord do
    constituent_sound { "MyString" }
    scale_type_id { 1 }
    root_note_id { 1 }
  end
end
