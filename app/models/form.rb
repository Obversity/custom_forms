class Form < ActiveRecord::Base
  has_many :fields
  has_many :submissions
  accepts_nested_attributes_for :fields
end
