class Admin::UsersController < Admin::Backend
  
  def index
    if !params[:user_ids].nil?
      User.destroy_all(["id in (?)", params[:user_ids]])
    end
    @users = User.paginate :page => params[:page], :per_page => 15, :order => "id desc"
  end

  def show
    @user = User.find(params[:id])
    @alerts = @user.alerts
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to [:admin, :users]
  end
  
end
