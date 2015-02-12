module Api
  class UsersController < ApiController
    def show
      @user = User.includes(:followed_users, :followers).find(params[:id])
      render :show
    end


    def index
      @users = User.all
      render json: @users
    end


  end

end
