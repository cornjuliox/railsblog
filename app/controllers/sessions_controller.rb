class SessionsController < ApplicationController
    include SessionsHelper

    def new
        if logged_in?
            flash.now[:success] = "You're already logged in!"
            redirect_to root_path
        end
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in user
            params[:session][:remember_me] = '1' ? remember(user) : forget(user)
            redirect_to user
        else
            flash.now[:danger] = 'Invalid email/password combination! Check and try again.'
            render 'new'
        end
    end

    def destroy
        log_out if logged_in?
        flash.now[:success] = 'Logged out, thanks for visiting!'
        redirect_to root_url
    end
end
