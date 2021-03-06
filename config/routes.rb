Halisaa::Application.routes.draw do

  # Admin side
  devise_for :admins, controllers: { sessions: 'hq/sessions',  registrations: 'hq/registrations', passwords: 'hq/passwords' }, path: 'hq',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification'},
             :skip => [:registrations]
  as :admin do
    get 'hq/edit' => 'hq/registrations#edit', :as => 'edit_admin_registration'
    put 'hq' => 'hq/registrations#update', :as => 'admin_registration'
  end
  namespace :hq do
    root to: 'dashboard#index'
    get 'language/:locale' => 'language#change', :as => 'change_language'
    resource :admin_profile, except: [:destroy], path: 'profile'
    resources :users, except: [:create, :new] do
      post :block, on: :member
      post :unblock, on: :member
      post :block_all, on: :collection
    end
    resources :admins, except: [:create, :new] do
      post :block, on: :member
      post :unblock, on: :member
      post :block_all, on: :collection
    end
    resources :companies, except: [:create, :new] do
      post :block, on: :member
      post :unblock, on: :member
      post :block_all, on: :collection
    end
  end

  # User side
  devise_for :users, controllers: { sessions: 'user/sessions',  registrations: 'user/registrations' }, path: 'user',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification'}
  namespace :user do
    resource :user_profile, except: [:destroy], path: 'profile', as: 'profile'
  end

  # Company side
  devise_for :companies, controllers: { sessions: 'company/sessions',  registrations: 'company/registrations' }, path: 'company',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification'}
  namespace :company do
    root to: 'dashboard#index'
    resource :company_profile, except: [:destroy], path: 'profile', as: 'profile'
  end

  # Geenral
  root to: 'welcome#index'
  get 'language/:locale' => 'language#change', :as => 'change_language'
  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'

end
