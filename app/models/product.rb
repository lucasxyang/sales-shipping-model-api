class Product < ApplicationRecord
	# model association
	has_many :composite_ones, dependent: :destroy
	has_many :document_lines, dependent: :destroy

	# validation
	validates_presence_of :name

end
