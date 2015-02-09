module Api
  class CommentsController < ApiController
    def create
      @comment = Comment.new(comment_params)
      @comment.author_id = current_user.id
      if @comment.save
        render json: @comment
      end
    end


    private

    def comment_params
      params.require(:comment).permit(:body, :author_id, :preview_id)
    end

  end
end
