#require 'csv'
class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :update, :destroy]

	# GET /products
	def index
		@products = Product.all
		json_response(@products)
	end

	# GET /products/:id
	def show
		json_response(@product)
	end

	# POST /products
	def create
		@product = Product.create!(product_params)
		json_response(@product, :created)
	end

	# PUT /products/:id
	def update
		@product.update(product_params)
		head :no_content
	end

	# DELETE /products/:id
	def destroy
		@product.destroy
		head :no_content
	end


	# custom actions

=begin
	def action_1
		#@products = Product.where("'name' like 'prod%'")
		@products1 = Product.where(created_at: (Time.now - 20.minute)..Time.now)
		puts @products1

		puts params.class
		puts 123
		#puts @products1.map(&:attributes)
		#@products1.to_yaml
		#puts @products1

	end
=end


	def action_2
		puts params
		permitted = params.permit(:start, :finish, :period)
		puts permitted
		print "... Permitted Parameters \n"

		@start = params[:start]
		@finish = params[:finish]
		@length = params[:period]
		lengthIsValid = false
		puts @start
		puts @finish
		puts @length

		#@products1 = Product.find_by_sql('SELECT "products"."id" AS "product_id", "name", strftime("%W", documents.created_at) AS "week_num", SUM(document_lines.qty) AS "qty_sum" FROM "products" INNER JOIN "document_lines" ON "document_lines"."product_id" = "products"."id" INNER JOIN "documents" ON "documents"."id" = "document_lines"."document_id" GROUP BY "products"."id", "products"."name", "week_num" ORDER by "week_num"')

		#puts @products1.class 
		#Product::ActiveRecord_Relation
		#puts @products1.first.class 
		#Products
		#puts @products1.first.created_at 
		#2017-11-24 18:03:07 UTC
		#puts @products1.first.created_at.class 
		#ActiveSupport::TimeWithZone
		#puts @products1.group_by{ |u| u.created_at.beginning_of_month }.class 
		#hash

		# products4 is based on products1 with different SQLite period groupers: j for day, W for week, and m for month
		if @length == 'day'
			lengthIsValid = true
			products4 = Product.find_by_sql('SELECT "products"."id" AS "product_id", "name", strftime("%j", documents.created_at) AS "day_num", SUM(document_lines.qty) AS "qty_sum" FROM "products" INNER JOIN "document_lines" ON "document_lines"."product_id" = "products"."id" INNER JOIN "documents" ON "documents"."id" = "document_lines"."document_id" GROUP BY "products"."id", "products"."name", "day_num" ORDER by "day_num"')
		elsif @length == 'week'
			lengthIsValid = true
			products4 = Product.find_by_sql('SELECT "products"."id" AS "product_id", "name", strftime("%W", documents.created_at) AS "week_num", SUM(document_lines.qty) AS "qty_sum" FROM "products" INNER JOIN "document_lines" ON "document_lines"."product_id" = "products"."id" INNER JOIN "documents" ON "documents"."id" = "document_lines"."document_id" GROUP BY "products"."id", "products"."name", "week_num" ORDER by "week_num"')
		elsif @length == 'month'
			lengthIsValid = true
			products4 = Product.find_by_sql('SELECT "products"."id" AS "product_id", "name", strftime("%m", documents.created_at) AS "month_num", SUM(document_lines.qty) AS "qty_sum" FROM "products" INNER JOIN "document_lines" ON "document_lines"."product_id" = "products"."id" INNER JOIN "documents" ON "documents"."id" = "document_lines"."document_id" GROUP BY "products"."id", "products"."name", "month_num" ORDER by "month_num"')
		else
			# error handling
		end


		# output to CSV
		if lengthIsValid
			CSV::open("test/file.csv", "wb") do |csv|
				#csv << products4.first.attributes.delete_if { |k, v| v.nil? }.keys # adds the attributes name on the first line as headers
				csv << ["product_name", "product_id", "period_num", "qty_sum"]

	      		products4.each do |productHash|
	      			puts productHash.class
	      			tempLine = productHash.attributes.delete_if { |k, v| v.nil? } # Ruby Enumerator (productHash.attributes) gives an array with nil "id" field. I do not want it
	      			puts tempLine
			        csv << tempLine.values
				end
			end
		end

		var1 = products4.to_json
		json_response(var1)

	end


	private

	def product_params
		# whitelist params
		params.permit(:name)
	end

	def set_product
		@product = Product.find(params[:id])
	end
end
