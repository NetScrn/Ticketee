Rails.application.routes.draw do
  devise_for :users
  root "projects#index"

  namespace :admin do
    root "application#index"

    resources :projects, only: [:new, :create, :destroy]
    resources :users
  end

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end
end
