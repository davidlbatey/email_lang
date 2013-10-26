EmailLang::Application.routes.draw do
  devise_for :users,
             :controllers => {
               :omniauth_callbacks => "users/omniauth_callbacks"
             }
  resources :contacts

  root to: 'pages#home'
end
