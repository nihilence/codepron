module Api
  class UsersController < ApiController
    def show
      curr = current_user.nil? ?  User.new() : current_user
      @user = User.find(params[:id])
      @previews = @user.previews
      @previews.page(params[:page]).per(6)
      render :json => {
        user: @user,
        previews: { models: @previews,
                    page_number: nil,
                    total_pages: 1
        },
        followers: @user.followers,
        followed_users: @user.followed_users,
        follows: @user.in_follows,
        is_followed: curr.follows?(@user)
      }
    end


    def index
      @users = User.all
      render json: @users
    end


  end

end
