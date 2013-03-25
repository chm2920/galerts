class OpenController < ApplicationController
  
  def new_user
    @user = User.find_by_uid(params[:uid])
    if @user.nil?
      @user = User.new
      @user.uid = params[:uid]
      @user.name = params[:name]
      @user.save
    end
    render :json => @user
  end
  
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
    @user = User.find_by_uid(params[:uid])
    if !@user.nil?
      @alerts = @user.alerts
    else
      render :json => "{'result' : '-1'}"
    end
  end
  
  def mails
    @alert = Alert.find(params[:id])
    if !@alert.nil?
      @mails = @alert.mails
      render :json => @mails
    else
      render :json => "{'result' : '-1'}"
    end
  end
  
end
