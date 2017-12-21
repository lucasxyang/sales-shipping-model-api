class Customer < ApplicationRecord

  # model association
  has_many :documents, dependent: :destroy

  # validations
  validates_presence_of :first_name

end
