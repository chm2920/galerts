#encoding: utf-8
class Admin::AdminsController < Admin::Backend
  
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end
  
  def create
    @admin = Admin.find_by_adminname(params[:admin][:adminname])
    if !@admin.nil?
      render :text => "<script>alert('用户名已存在!');location.href='javascript:history.back(-1)';</script>"
      return
    end
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to [:admin, :admins]
    else
      render :action => "new"
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if !params[:admin][:password].blank?
      @admin.adminname = params[:admin][:adminname]
      @admin.password = Digest::MD5.hexdigest(params[:admin][:password])
      @admin.save!
    end
    redirect_to [:admin, :admins]
  end

  def destroy
    @admin_length = Admin.all.length
    if @admin_length == 1
      render :text => "<script>alert('最后一个管理员不能删除!');location.href='javascript:history.back(-1)';</script>"
      return
    end
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to [:admin, :admins]
  end
  
end
