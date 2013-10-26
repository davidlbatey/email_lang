EmailLang::Application.routes.draw do

  resources :contacts

  devise_for :users
  root to: 'pages#home'

end
