
class SessionsController < ApplicationController

  def create;
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      login(@user)
      redirect_to ''
    else
      flash.now[:errors] = "Invalid credentials"
      render '/sessions/new'
    end
  end

  def destroy
    sign_out!
    redirect_to ''
  end

  private

end
