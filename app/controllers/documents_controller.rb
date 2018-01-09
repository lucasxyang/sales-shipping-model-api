class DocumentsController < ApplicationController
  before_action :set_customer
  before_action :set_customer_document, only: [:show, :update, :destroy]

  # GET /customers/:customer_id/documents
  def index
    json_response(@customer.documents)
  end

=begin
  # GET /customers/:customer_id/documents/:id
  def show
    json_response(@document)
  end

  # POST /customers/:customer_id/documents
  def create
    @customer.documents.create!(document_params)
    json_response(@customer, :created)
  end

  # PUT /customers/:customer_id/documents/:id
  def update
    @document.update(document_params)
    head :no_content
  end

  # DELETE /customers/:customer_id/documents/:id
  def destroy
    @document.destroy
    head :no_content
  end
=end

  private

  def document_params
    params.permit(:status, :placed_on)
  end

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_customer_document
    @document = @customer.documents.find_by!(id: params[:id]) if @customer
  end


end
