EmailLang::Application.routes.draw do
  devise_for :users,
             :controllers => {
               :omniauth_callbacks => "users/omniauth_callbacks",
               :sessions => "users/sessions"
             }
  resources :contacts
  resources :accounts, :only => [:index]
  resources :users, :only => [] do
    collection do
      get 'youtube'
    end
  end

  root to: 'pages#home'

  get '/dashboard' => 'pages#dashboard'
end
