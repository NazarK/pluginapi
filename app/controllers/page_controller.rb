class PageController < ApplicationController
  layout 'raw'
  def install
    @installation = Installation.new
    @installation.save
  end

  def data_post
    @installation = Installation.find_by_id(params[:id])
    @installation.data = params[:data]
    @installation.save

  end

  def data_get
    @installation = Installation.find_by_id(params[:id])
  end
end
