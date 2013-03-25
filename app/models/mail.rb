class Mail < ActiveRecord::Base
  
  attr_accessible :alert_id, :summary, :received_at, :body
  
  belongs_to :alert
  
end
