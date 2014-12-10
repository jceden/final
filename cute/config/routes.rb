Rails.application.routes.draw do


  devise_for :users
  resources :images do
	resources :posts, shallow: true
  end
  patch 'image/:id/yes_vote' => 'images#yes_vote'
  patch 'image/:id/no_vote' => 'images#no_vote'

root 'images#index'
end
