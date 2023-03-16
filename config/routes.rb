Rails.application.routes.draw do
    ########## ADMINSTRATIONS ##########
    # authenticated :user, ->(user) { user.administrateur? } do
        get 'administration', to: 'administration#index'
        get 'administration/articles'
        get 'administration/commentaires'
        get 'administration/users'
        get 'administration/show_article/:id', to: 'admin#show_article', as: 'administration_article'
    # end
    ########## UTILISATEURS ##########
    devise_for :users, controllers: {
        # sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
    get 'profile/:id', to: 'users#profile', as: 'profile'

    ########## FOLLOWER (suivre) ##########
    # suivre l'utilisateur
    post 'profile/follow', to: 'users#follow'
    delete 'profile/unfollow', to: 'users#unfollow'
    ########## PAGES ##########
    root 'pages#accueil', to: 'pages#accueil'
    get 'boutique', to: 'pages#boutique', as: 'boutique'
    get 'contact', to: 'pages#contact', as: 'contact'
    get 'a_propos', to: 'pages#about', as: 'about'
    ########## ARTICLES + COMMENTAIRES + CATEGORIES + TAGS ##########
    resources :articles do
        resources :commentaires
    end
    resources :categories
    resources :tags
    ########## LIKES ARTICLES ##########
    resources :likes, only: %i[ create destroy ]
    ########## RECHERCHE ##########
    get 'recherche', to: 'recherche#index'
    ########## PROJETS ##########
    resources :projets
    ########## PRODUITS ##########
    get 'cart', to: 'cart#show'
    post 'cart/add'
    post 'cart/remove'
    resources :produits
end
