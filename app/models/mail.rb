class Mail < ActiveRecord::Base
  
  attr_accessible :alert_id, :body, :received_at
  
  belongs_to :alert
  
end
