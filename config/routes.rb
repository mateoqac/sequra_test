Rails.application.routes.draw do
	namespace :api do
		resources :disbursements, only: [:index]
	end
end