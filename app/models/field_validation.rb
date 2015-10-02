class FieldValidation < ActiveRecord::Base
  belongs_to :field

  VALIDATION_TYPES = {
    1=>{name:'required', message: 'is required'},
    2=>{name:'email', message:'must be a valid email'},
    3=>{name:'regex', message:'does not fit the necessary format'},
    4=>{name:'datetime', message:'must be a valid date'},
    5=>{name:'number', message:'must be a number'},
    6=>{name:'length', message:'has a maximum length'}
  }

  def self.required(value)
    return !value.blank?
  end

  def self.email(value)
    (value =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

end
