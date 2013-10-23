class SessionsController < ApplicationController
    skip_before_filter :authorize, only: [:new, :create]

def new
	@instructor = Instructor.new
end


def create
     @instructor = Instructor.find_by_username(params[:instructor][:username])
     if @instructor && @instructor.authenticate(params[:instructor][:password])              
          cookies.permanent[:remember_token] = @instructor.remember_token
          sign_in(@instructor)
          redirect_to instructor_path(@instructor.id)
     else
          flash[:errors] = "Error!"
          render :new
     end
end


def destroy
     cookies.delete(:remember_token)
     redirect_to new_session_path
end


end
