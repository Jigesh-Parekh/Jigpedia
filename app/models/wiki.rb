class Wiki < ActiveRecord::Base
  belongs_to :user
  before_create { self.private = false; true}
 # scope :visible_to, -> (user) { user.admin? || user. ? all : where(private: false)}

  scope :public_view, -> {where(private: false)}
  #scope :private_view, -> {user.admin ? user.premium : where(private = true)} 
  scope :private_view, -> {where(private: true)} 
  scope :visible_to, -> (user) {user ? all : public_view; user.premium? || user.admin? ? all : private_view}

 
 #def self.visible_to (user)
 #		if user.admin?
 #			all
 #		elsif user.premium?
 #			where(private: true , private: false)
 #		elsif user.standard?
 #			where(private: false)
 #		end
  #end
end
