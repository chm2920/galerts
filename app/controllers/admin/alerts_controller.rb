class Admin::AlertsController < Admin::Backend
  
  def index
    if !params[:alert_ids].nil?
      Alert.destroy_all(["id in (?)", params[:alert_ids]])
    end
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
