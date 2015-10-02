class Field < ActiveRecord::Base
  belongs_to :form
  has_many :field_options
  has_many :field_validations

  TYPES = {
    "string" => "Text",
    "text" => "Textbox",
    "boolean" => "Checkbox"
  }

end
