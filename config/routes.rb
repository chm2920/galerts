Galerts::Application.routes.draw do
  
  post "/sub", :to => "open#subscribe"
  
    
  match "admin" => "account#login"
  get "account/main"
  get "account/desktop"
  match "admin_login_rst" => "account#login_rst"
  match "admin_logout" => "account#logout"
  
  namespace :admin do
    resources :users
    
    resources :alerts
    
    resources :mails
    
    post "run_logs/index"
    get "run_logs/clear"
    resources :run_logs
    
    resources :admins
  end
  
  root :to => "start#index"
  
  match "*path" => "application#render_not_found"
  
end
