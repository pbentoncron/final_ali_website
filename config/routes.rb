Rails.application.routes.draw do

  resources :users, :sessions, :contacts, :reviews
  get '/about' => 'users#about'
  get '/services' => 'users#services'
  get '/portfolio' => 'users#portfolio'
  get '/admin' => 'sessions#require_admin'
  get '/testimonials' => 'reviews#testimonials'
  post '/send_mail' => 'contact#send_mail'
  put '/update_two/:id' => 'reviews#update_two'
  root 'users#home'
  match '*path' => redirect('/'), via: :get

end