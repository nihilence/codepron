
class SessionsController < ApplicationController

  def create;
    @user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    if @user
      login(@user)
      redirect_to ''
    else
      flash.now[:errors] = "Invaid credentials"
      redirect_to 'session/new'
    end
  end

  def destroy
    sign_out!
    redirect_to ''
  end

  private

end
