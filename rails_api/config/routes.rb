Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :books do
      collection do
        get 'fetch_api'
        post "delete_selected"
      end
    end
  end
end
