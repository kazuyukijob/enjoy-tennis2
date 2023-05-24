Rails.application.routes.draw do
  #devise_for :users
  #devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ユーザー
  scope module: :public do
    root to: 'homes#top'
    get "home/about"=> 'homes#about'
    resources :users, only: [:show, :edit, :update, :index] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :reviews, only: [:new, :show, :edit, :create, :update, :destroy] do
      #いいねはレビューにネストする形で記載
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :tennis_courts, only: [:show, :edit, :index] do
      #コートidだけ引き継ぎたいからネストしてurlに混ぜる
      resources :reviews, only: [:index]
    end
  end

  #ゲストログイン
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :tennis_courts, only: [:new, :show, :edit, :index, :create, :update, :destroy]
    resources :users, only: [:new, :show, :edit, :index, :create]
      resources :reviews, only: [:index, :destroy]
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