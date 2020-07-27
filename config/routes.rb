Rails.application.routes.draw do

  root 'posts#index'
  delete 'remove_friend' => 'friendships#destroy'
  get 'send_request' => 'friendships#send_request'
  get 'accept_invite' => 'friendships#accept_invitation'
  get 'pending_request' => 'friendships#pending_invitation'
  delete 'reject_invite' => 'friendships#reject_invitation'



  devise_for :users
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
