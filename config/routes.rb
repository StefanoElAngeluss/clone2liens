Rails.application.routes.draw do
    ########## ADMINSTRATIONS ##########
    authenticated :user, ->(user) { user.administrateur? } do
        get 'administration', to: 'administration#index'
        get 'administration/articles'
        get 'administration/commantaires'
        get 'administration/users'
        get 'administration/show_article/:id', to: 'admin#show_article', as: 'administration_article'
    end
    ########## UTILISATEURS ##########
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
    resources :categories
    ########## LIKES ARTICLES ##########
    resources :likes, only: %i[ create destroy ]
    ########## RECHERCHE ##########
    get 'recherche', to: 'recherche#index'
end
