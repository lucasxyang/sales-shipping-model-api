Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers do
	#resources :documents
	get '/documents' => 'documents#index'
  end

  resources :documents do
  	resources :document_lines
  end

  get 'products/action_2' => 'products/action_2'
  #post 'products/action_2' => 'products/action_2'

  resources :products
  resources :categories

end
