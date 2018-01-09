class Category < ApplicationRecord
  # model association
  has_many :composite_ones
  
  # validation
  validates_presence_of :name
end
