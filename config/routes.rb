Infoready::Application.routes.draw do
  root :to => "home#index"
  
  resources :home do
    collection do
      get :populate_data
    end
  end

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
end
