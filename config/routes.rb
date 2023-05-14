Rails.application.routes.draw do
  #devise_for :users
  #devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ユーザー
  scope module: :public do
    root to: 'homes#top'
    get "home/about"=> 'homes#about'
    resources :users, only: [:show, :edit, :update, :index]
    resources :reviews, only: [:new, :show, :edit, :create, :update, :destroy, :index]
    resources :tennis_courts, only: [:show, :edit, :index]
  end

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :tennis_courts, only: [:new, :show, :edit, :index, :create, :update, :destroy]
    resources :users, only: [:new, :show, :edit, :index, :create]
  end

# ユーザー
# URL /customers/sign_in ...
devise_for :user,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end