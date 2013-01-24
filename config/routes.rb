Galerts::Application.routes.draw do
  
  post "/sub", :to => "open#subscribe"
  
  resources :mails

  resources :alerts

  
  resources :users
  
  root :to => "start#index"
  
end
