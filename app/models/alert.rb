class Alert < ActiveRecord::Base
  
  attr_accessible :title
  
  has_and_belongs_to_many :users
  
  has_many :mails
  
  def post_remote
    params = {}  
    params["q"] = self.title
    params["t"] = 7
    params["f"] = 1
    params["l"] = 0
    params["e"] = 'alerts@nxyouxi.com'
    
    require 'net/http'
    uri = URI.parse("http://www.google.com/alerts/create")
    puts "begin post #{self.title}"
    res = Net::HTTP.post_form(uri, params)
    puts res.body
    begin
      if res.body.to_s.include? ("Google Alert Created")        
        MailLog.create(:info => "#{self.title} -- Google Alert Created")
      else
        MailLog.create(:info => "#{self.title} failed")
      end
    rescue
      MailLog.create(:info => "#{self.title} post error")
    end
    puts "post end"
  end
  
end
