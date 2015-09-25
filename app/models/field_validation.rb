class FieldValidation < ActiveRecord::Base
  belongs_to :field

  VALIDATION_TYPES = {
    1=>'required',
    2=>'email',
    3=>'regex',
    4=>'datetime',
    5=>'number',
    6=>'length'
  }


  def self.required(value)
    return !value.blank?
  end

  def self.email(value)
    (value =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

end
