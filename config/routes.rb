Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'nasa_images#new'  
  resources :nasa_images    
end
