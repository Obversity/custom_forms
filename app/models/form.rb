class Form < ActiveRecord::Base
  has_many :fields
  has_many :submissions
end
