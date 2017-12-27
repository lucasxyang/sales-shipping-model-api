class Product < ApplicationRecord
	# model association
	has_many :composite_ones, dependent: :destroy
	has_many :document_lines, dependent: :destroy

	# validation
	validates_presence_of :name


	def self.to_csv
		attributes = %w{product_id name day_num qty_sum}

		CSV.generate(headers: true) do |csv|
			csv << attributes

			all.each do |user|
				csv << attributes.map{ |attr| user.send(attr) }
			end
		end
	end

end
