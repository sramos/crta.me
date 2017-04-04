Rails.application.routes.draw do
  resources :stored_urls
  get "/:slug" => "stored_urls#redirect", as: :url_go
end
