class HomeController < ApplicationController
  def index
    response = Indexers.get_selic_rate
    @selic = (response.last['valor'].to_f * 30.44).round(2)
  end

  def upload_image
    image = params[:image]
    response = ImgbbService.upload_image(IMGBB_KEY, image)
    
    puts JSON.parse(response)
    data = JSON.parse(response)
  end  
end
