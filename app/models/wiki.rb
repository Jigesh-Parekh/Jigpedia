class Wiki < ActiveRecord::Base
  belongs_to :user
  before_create { self.private = self.private || false; true}
 # scope :visible_to, -> (user) { user.admin? || user. ? all : where(private: false)}

  scope :public_view, -> {where(private: true)}
  #scope :private_view, -> {user.admin ? user.premium : where(private = true)} 
  scope :private_view, -> {where(private: false)} 
  #scope :visible_to, -> (user) {user.standard? ? public_view : public_view; user.premium? || user.admin? ?  public_view : private_view}

 
 def self.visible_to (user)
 	     privVar = where(private: true)
  		 pubVar = where(private: false)	
 		if user.admin?
 				all
 		elsif user.premium? 		
 				

 				
 				all 

 				#if current_user?
 				#	privVar && pubVar
 				#else
 				#	pubVar
 				#end


 				#privVar && pubVar
 				#where(private: true) #OR private: false )  #Wiki.all 
 				#where(private: false)
 		elsif user.standard?
 				where(private: false)
 		end
  end
end
