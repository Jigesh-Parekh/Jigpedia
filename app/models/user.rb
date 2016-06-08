class User < ActiveRecord::Base
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :admin, :premium]
  after_initialize :default_role
  
  def default_role
  	self.role ||= :standard
  end
  
end
