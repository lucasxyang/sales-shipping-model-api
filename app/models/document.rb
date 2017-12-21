class Document < ApplicationRecord
  # model association
  belongs_to :customer
  has_many :document_lines, dependent: :destroy

  # validation
  validates_presence_of :status
  #validates_presence_of :placed_on
end
