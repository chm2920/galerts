class Admin::AlertsController < Admin::Backend
  
  def index
    if !params[:alert_ids].nil?
      Alert.destroy_all(["id in (?)", params[:alert_ids]])
    end
    @alerts = Alert.paginate :page => params[:page], :per_page => 15, :order => "id desc"
  end

  def new
    @alert = Alert.new
  end
  
  def create
    @alert = Alert.find_by_title(params[:alert][:title])
    if !@alert.nil?
      render :text => "<script>alert('Existed !');location.href='javascript:history.back(-1)';</script>"
      return
    end
    @alert = Alert.new(params[:alert])
    if @alert.save
      @alert.post_remote
      redirect_to [:admin, :alerts]
    else
      render :action => "new"
    end
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
