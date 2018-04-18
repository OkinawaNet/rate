Rails.application.routes.draw do
  get 'admin', to: 'admin#index'

  post 'admin/rate_update', to: 'admin#rate_update'
  patch 'admin/rate_update', to: 'admin#rate_update'

  root 'guest#index'
end