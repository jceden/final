Rails.application.routes.draw do


  devise_for :users
  resources :images do
	resources :posts, shallow: true
	get :cute_vote
  end

root 'images#index'
end
