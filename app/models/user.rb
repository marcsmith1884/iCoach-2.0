class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, 
           :confirmable, :trackable, :lockable,
           :omniauthable, omniauth_providers: [:google_oauth2, :github, :twitter]
           
 include Roleable           
           
  
  def self.from_omniauth(access_token)
   data = access_token.info
    user = User.where(email: data['email']).first

     unless user
         user = User.create(
            email: data['email'],
            password: Devise.friendly_token[0,20]
         )
     end
     user.provider = access_token.provider
     user.uid = access_token.uid
     unless user.name.present?
      user.name = access_token.info.name
     end 
     user.image = access_token.info.image
     user.save
     
     user.confirmed_at = Time.now # autoconfirm user from omniauth
    user
  end
  
 # after_create do
   #It will assign a default role
  # self.update(Users: true)
  # end
  
  def to_s
   email
  end
  
end 
