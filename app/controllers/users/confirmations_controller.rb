class Users::ConfirmationsController < Devise::ConfirmationsController
    private
    def after_confirmation_path_for(resource_name, resource)
        sign_in(resource) # Just in case you would like to sign in the user
        root_path
    end
end     