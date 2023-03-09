Rails.application.routes.draw do
  get 'recherche', to: 'recherche#index'
    get 'profile/:id', to: 'users#profile', as: 'profile'
    devise_for :users#, controllers: {
        # sessions: 'users/sessions'
    # }
    ########## PAGES ##########
    root 'pages#accueil', to: 'pages#accueil'
    get 'boutique', to: 'pages#boutique', as: 'boutique'
    get 'contact', to: 'pages#contact', as: 'contact'
    get 'a_propos', to: 'pages#about', as: 'about'
    ########## ARTICLES ##########
    resources :articles do
        resources :commentaires
    end
    resources :likes, only: %i[ create destroy ]
end
