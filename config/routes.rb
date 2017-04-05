Rails.application.routes.draw do
  resources :stored_urls
  get "/:slug" => "stored_urls#redirect", as: :destination
  root 'stored_urls#new'
end
