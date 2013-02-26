class Admin::MailsController < Admin::Backend
  
  def index
    if !params[:mail_ids].nil?
      Mail.destroy_all(["id in (?)", params[:mail_ids]])
    end
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
