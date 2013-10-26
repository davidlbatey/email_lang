EmailLang::Application.routes.draw do
  devise_for :users,
             :controllers => {
               :omniauth_callbacks => "users/omniauth_callbacks",
               :sessions => "users/sessions"
             }
  resources :contacts
  resources :accounts, :only => [:index]

  root to: 'pages#home'
end
