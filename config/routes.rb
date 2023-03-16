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
    # ne pas suivre l'utilisateur
    # post 'unfollow/:id', to: 'users#unfollow', as: 'unfollow'
    # accept l'invitation l'invitation de l'utilisateur
    # post 'accept/:id', to: 'users#accept', as: 'accept'
    # annule l'invitation de l'utilisateur
    # post 'decline/:id', to: 'users#decline', as: 'decline'
    # supprimer l'invitation de l'utilisateur
    # post 'cancel/:id', to: 'users#cancel', as: 'cancel'
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

end
