class OpenController < ApplicationController
  
  def subscribe
    @user = User.find_by_uid(params[:uid])
    if @user.nil?
      @user = User.new(:uid => params[:uid], :name => 'temp')
      @user.save
    end
    @alert = Alert.find_by_title(params[:k])
    if @alert.nil?
      @alert = Alert.new(:title => params[:k])
      @alert.save
    end
    result = @alert.generate
    if result != 'failed'
      render :text => result
    else
      render :text => result
    end
    #@user.alerts << @alert
  end
  
  def alerts
    @user = User.find_by_uid(params[:id])
    @alerts = @user.alerts
  end
  
  def mail
    @alert = Alert.find(params[:id])
    @mail = @alert.mail
  end
  
end
