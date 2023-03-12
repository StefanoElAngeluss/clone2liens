Rails.application.routes.draw do
  get 'membres/dashboard'

    ########## ADMINSTRATIONS ##########
    authenticated :user, ->(user) { user.administrateur? } do
        get 'administration', to: 'administration#index'
        get 'administration/articles'
        get 'administration/commentaires'
        get 'administration/users'
        get 'administration/show_article/:id', to: 'admin#show_article', as: 'administration_article'
    end
    ########## UTILISATEURS ##########
    get 'profile/:id', to: 'users#profile', as: 'profile'
    devise_for :users, controllers: {
        # sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
    ########## PAGES ##########
    root 'pages#accueil', to: 'pages#accueil'
    get 'boutique', to: 'pages#boutique', as: 'boutique'
    get 'contact', to: 'pages#contact', as: 'contact'
    get 'a_propos', to: 'pages#about', as: 'about'
    ########## ARTICLES ##########
    resources :articles do
        resources :commentaires
    end
    resources :categories
    resources :tags
    ########## LIKES ARTICLES ##########
    resources :likes, only: %i[ create destroy ]
    ########## RECHERCHE ##########
    get 'recherche', to: 'recherche#index'
    ########## STRIPE PAY ##########
    get 'checkout', to: 'checkouts#show'
    get 'checkouts/success', to: 'checkouts#success'
    get 'billing', to: 'billing#show'

end
