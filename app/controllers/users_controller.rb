class UsersController < ApplicationController
    
    before_action :require_admin, only: [:edit, :update, :ban, :destroy]
    
    def index
        @users = User.all.order(created_at: :asc)
    end
    
    def edit
        @user = User.find(params[:id])
    end    
    
    def update
       @user = User.find(params[:id]) 
       @user.update(user_params)
       if @user.update(user_params)
          redirect_to @user, notice: "The user was updated successfully"
       else
         render :edit
       end
    end
    
    
    def show
        @user = User.find(params[:id])
    end
    
    def ban
    @user = User.find(params[:id])
    if @user.access_locked?
        @user.lock_access!
    else
        @user.lock_access!
    end 
        redirect_to @user, notice: "User access locked: #{@user.access_locked?}"
    end
    
    
    def destroy 
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path, notice: "User was deleted successfully"
    end
    


 private

 def user_params
    params.require(:user).permit(*User::ROLES, :name)
 end 
 
 def require_admin
    unless current_user.admin?
     redirect_to root_path, alert: "Your are not authorised to carry out this action"
    end 
 end 
 
end 