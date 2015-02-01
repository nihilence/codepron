module Api
  class PreviewsController < ApiController

    def show
      @preview = Preview.find(params[:id])
      render :show
    end

    def index
      @previews = Preview.all
      render json: @previews
    end



    private

    def preview_params
      params.require(:preview).permit(:title, :html_input)
    end


  end
end
