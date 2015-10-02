class Field < ActiveRecord::Base
  belongs_to :form
  has_many :field_options
  has_many :field_validations

  TYPES = {
    "string" => "Text",
    "text" => "Textbox",
    "email" => 'Email',
    "url" => 'URL',
    'tel' => 'Phone',
    "integer" => 'Number',
    "boolean" => "Checkbox"
  }

  def errors2(data)

    e = []
    field_validations.each do |validation|
      # check what kind of validation we're doing.
      validation_type = FieldValidation::VALIDATION_TYPES[validation.validation_id]

      # check whether the value validates
      valid = FieldValidation.send(validation_type[:name], data)

      # push error messages into the e array
      e << validation_type[:message] unless valid
    end

    e
  end

end
