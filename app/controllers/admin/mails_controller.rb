class Admin::MailsController < Admin::Backend
  
  def index
    @mails = Mail.paginate :page => params[:page], :per_page => 15, :order => "id desc"
  end

  def show
    @mail = Mail.find(params[:id])
  end

  def destroy
    @mail = Mail.find(params[:id])
    @mail.destroy
    redirect_to [:admin, :mails]
  end
  
end
