Rails.application.routes.draw do
  get 'home/index'
  root "home#index"  

  resources :articles do
    resources :comments
  end

  resources :authors do
    resources :articles
  end

end
