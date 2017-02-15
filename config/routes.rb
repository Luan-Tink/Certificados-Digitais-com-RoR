Rails.application.routes.draw do
  get 'certificate/create'

  post 'certificate/sign'

  post 'certificate/verify'

  post 'certificate/auth'

  get 'certificate/new'

  get 'certificate/sign_view'

  get '/certificate/verify_view'

  get '/certificate/auth_view'

  root "certificate#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
