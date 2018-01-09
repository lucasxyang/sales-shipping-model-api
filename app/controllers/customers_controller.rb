class CustomersController < ApplicationController
	before_action :set_customer, only: [:show, :update, :destroy]

	# GET /customers
	def index
		@customers = Customer.all
		json_response(@customers)
	end

	# GET /customers/:id
	def show
		json_response(@customer)
	end

	# POST /customers
	def create
		@customer = Customer.create!(customer_params)
		json_response(@customer, :created)
	end

	# PUT /customers/:id
	def update
		@customer.update(customer_params)
		head :no_content
	end

	# DELETE /customers/:id
	def destroy
		@customer.destroy
		head :no_content
	end



	private

	def customer_params
		# whitelist params
		params.permit(:first_name, :last_name)
	end

	def set_customer
		@customer = Customer.find(params[:id])
	end
end
