class User < ActiveRecord::Base
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #before_action :authenticate_user!
  #user_signed_in?
  #current_user
  #user_session


end
