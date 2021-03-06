Rails.application.routes.draw do

  root "pages#index"

  devise_for :users,
             :skip         => [:sessions],
             :controllers  => { :omniauth_callbacks => "users/omniauth_callbacks" }

  as :user do
    match "login",   :to => "sessions#new",      :via => :get,     :as => :new_user_session
    match "logout",  :to => "sessions#destroy",  :via => :delete,  :as => :destroy_user_session
  end

  resources :users, :only => [:show, :edit, :update] do
    post :edit_job,     :on => :member, :as => :edit_job
    post :edit_name,    :on => :member, :as => :edit_name
    post :update_job,   :on => :member, :as => :update_job
    post :update_name,  :on => :member, :as => :update_name
  end

  resources :recipes

  get :paginate, :as => :paginate, :to => "pages#paginate"
  get :search,   :as => :search,   :to => "pages#search"

  resources :votes, :only => [] do
    post :toggle,   :on => :member, :as => :toggle
    post :create,   :on => :member, :as => :create
    post :destroy,  :on => :member, :as => :destroy
  end

  resources :comments, :only => [:create, :update, :destroy, :edit]

end
