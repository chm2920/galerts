class Admin::AlertsController < Admin::Backend
  
  def index
    @alerts = Alert.paginate :page => params[:page], :per_page => 15, :order => "id desc"
  end

  def show
    @alert = Alert.find(params[:id])
    @users = @alert.users
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    redirect_to [:admin, :alerts]
  end
  
end
