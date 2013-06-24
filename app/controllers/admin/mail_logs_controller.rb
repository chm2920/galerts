class Admin::MailLogsController < Admin::Backend
   
  def index
    if !params[:mail_log_ids].nil?
      MailLog.destroy_all(["id in (?)", params[:mail_log_ids]])
    end
    @mail_logs = MailLog.paginate :page => params[:page], :per_page => 15, :order => "id desc"
  end
  
  def destroy
    @log = MailLog.find(params[:id])
    @log.destroy
    redirect_to [:admin, :mail_logs]
  end
  
  def clear
    MailLog.destroy_all
    redirect_to [:admin, :mail_logs]
  end
  
end
