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

    def update
      @preview = Preview.find(params[:id])
      @preview.combined = Preview.build_html(params[:preview][:html], params[:preview][:css],
                          params[:preview][:js])
      if @preview.update(preview_params)
        render json: @preview
      else
        render json: @preview.errors.full_messages
      end
    end

    def create
      @preview = Preview.new(preview_params)
      @preview.combined = Preview.build_html(params[:preview][:html], params[:preview][:css],
      params[:preview][:js])
      if @preview.save
        render json: @preview
      end
    end




    private

    def preview_params
      params.require(:preview).permit(:title, :html, :description, :css, :js)
    end


  end
end
