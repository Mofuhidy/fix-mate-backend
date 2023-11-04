Rails.application.routes.draw do
 root to: 'api/v1/experts#index'
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get "up" => "rails/health#show", as: :rails_health_check

  # resources :experts, only: [:index, :new, :create, :show ] do
  #   member do
  #     put :toggle_remove
  #   end
  #   resources :specializations, only: [:index,:new, :show]
  # end

  namespace :api do
    namespace :v1 do
      resources :reservations, only: [:index, :create]
      resources :experts, only: [:index, :new, :create, :show] do
        member do
          put :toggle_remove
        end
      end
      resources :users
      resources :specializations, only: [:create]
    end
  end
end
