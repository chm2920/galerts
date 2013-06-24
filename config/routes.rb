Galerts::Application.routes.draw do
  
  match "/init", :to => "open#new_user"
  post "/sub", :to => "open#subscribe"
  match "/alerts", :to => "open#alerts"
  match "/mails", :to => "open#mails"
  
    
  match "admin" => "account#login"
  get "account/main"
  get "account/desktop"
  match "admin_login_rst" => "account#login_rst"
  match "admin_logout" => "account#logout"
  
  namespace :admin do    
    resources :mails do
      collection do
        get :index
      end
    end
    
    resources :mail_logs do
      collection do
        get :clear
        post :index
        get :index
      end
    end
    
    post "users/index"
    resources :users
    
    post "alerts/index"
    resources :alerts
    
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
