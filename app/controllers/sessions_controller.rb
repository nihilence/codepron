class SessionsController < ApplicationController

  def create;
    @user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    puts @user
    if @user
      login(@user)
      render json: @user
    else
      flash[:errors] = "Invaid credentials"
      # redirect_to 'session/new'
      render json: "errror"
    end
  end

  private

end
