class User < ActiveRecord::Base
  
  attr_accessible :uid, :name
  
  has_and_belongs_to_many :alerts
  
  def subscribe(k)
    
  end
  
end
