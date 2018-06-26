Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :accounts, only: %i[show create update destroy]
  end
end
