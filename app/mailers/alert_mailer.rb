class AlertMailer < ActionMailer::Base
  default from: "alerts@nxyouxi.com"
  
  def welcome
    mail(:to => "395693519@qq.com", :subject => "Welcome")
  end
  
  def receive(email)
    # page = Page.find_by_address(email.to.first)
    # page.emails.create(
      # :subject => email.subject,
      # :body => email.body
    # )
    puts "================="
    puts email.to.first
  end
  
end
