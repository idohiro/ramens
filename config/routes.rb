Rails.application.routes.draw do
  root :to =>"homes#top"
  get 'homes/about'

  namespace :admin do
    resources :customers, only: [:index, :show]
  end
  namespace :public do
    get 'customers/confirm'
     resources :customers, only: [:index, :edit, :update, :create, :show] do
        collection do
      patch :withdraw
      end
    end
     resources :searchs, only: [:search, :search_result]
     resources :relationships, only: [:followers, :followings, :create, :destroy]
     resources :ramens, only: [ :index, :edit, :update, :create, :show, :destroy, :new]
     resources :ramen_comments, only: [:create, :destroy]
     post 'ramen/:id' => 'ramens#show'
  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
