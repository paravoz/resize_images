Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :user_sessions, only: :create
      resources :raw_images, only: %i(index show create)
      resources :resize_images, only: %i(index show create)
    end
  end
end
