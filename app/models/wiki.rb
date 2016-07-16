class Wiki < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  #pretend its a user but call it creator
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user
  
  before_create { self.private = self.private || false; true}

  scope :public_view, -> {where(private: false)}

  scope :private_view, -> {where(private: true)} 

 
 def self.visible_to (user)
	
 		if user.admin?
 				all
 		elsif user.premium? 
 				where("(private = ?) OR ((private = ?) AND (user_id = ?))", false, true, user.id)
 		elsif user.standard?
 				where(private: false)
 		end
  end

end
