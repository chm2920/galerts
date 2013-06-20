class Alert < ActiveRecord::Base
  
  attr_accessible :title
  
  has_and_belongs_to_many :users
  
  has_many :mails
  
  def generate
    params = {}  
    params["q"] = self.title
    params["t"] = 7
    params["f"] = 1
    params["l"] = 0
    params["e"] = 'alerts@nxyouxi.com'
    
    require 'net/http'
    uri = URI.parse("http://www.google.com/alerts/create")
    res = Net::HTTP.post_form(uri, params)
    puts '##########'
    puts res.body
    puts '##########'
    if res.body.inclue("Google Alert Created")
      res.body
    else
      'failed'
    end    
  end
  
end
