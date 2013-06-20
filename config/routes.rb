Galerts::Application.routes.draw do
  
  post "/sub", :to => "open#subscribe"
  
    
  match "admin" => "account#login"
  get "account/main"
  get "account/desktop"
  match "admin_login_rst" => "account#login_rst"
  match "admin_logout" => "account#logout"
  
  namespace :admin do
    post "users/index"
    resources :users
    
    post "alerts/index"
    resources :alerts
    
    post "mails/index"
    resources :mails
    
    post "run_logs/index"
    get "run_logs/clear"
    resources :run_logs
        
    get "db/index"
    
    post "db/backup"
    post "db/restore"
    delete "db/destroy"
    
    get "db/sql"
    post "db/sql"
    
    get "db/tables"
    get "db/structure"
    post "db/export_sql"
    
    resources :admins
  end
  
  root :to => "start#index"
  
  match "*path" => "application#render_not_found"
  
end
