class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
    else
      flash[:errors] = @user.errors.full_messages
    end

    redirect_to ''
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
