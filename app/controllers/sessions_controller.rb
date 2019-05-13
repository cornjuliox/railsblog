class SessionsController < ApplicationController
    def new
        if helpers.logged_in?
            flash.now[:success] = "You're already logged in!"
            redirect_to root_url
        end
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            helpers.log_in user
            redirect_to user
        else
            flash.now[:danger] = 'Invalid email/password combination! Check and try again.'
            render 'new'
        end
    end

    def destroy
        helpers.log_out
        flash.now[:success] = 'Logged out, thanks for visiting!'
        redirect_to root_url
    end
end
