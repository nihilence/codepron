class HtmldocsController < ApplicationController

  def show
    @preview = Preview.find(params[:id])
    puts @preview
    render inline: @preview.combined
  end

end
