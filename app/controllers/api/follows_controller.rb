module Api
  class FollowsController < ApplicationController

    def create
      @follow = Follow.new(follow_params)
      @follow.follower_id = current_user.id
      if @follow.save
        render json: @follow
      end
    end

    def destroy
      @follow = Follow.find(params[:id])
      @follow.destroy
      render json: {}
    end

    def show
      @follow = Follow.find(params[:id])
      render json: @follow
    end


    private

    def follow_params
      params.require(:follow).permit(:follower_id, :followed_id)
    end
  end
end
