require 'net/http'
require 'base64'

class ImgbbService
  API_URL = 'https://api.imgbb.com/1/upload'.freeze

  def self.upload_image(api_key, image)
    uri = URI(API_URL)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)

    base64_image = Base64.strict_encode64(image.tempfile.read)
    request.set_form_data(
      'key' => api_key,
      'image' => base64_image
    )

    response = http.request(request)

    response.body
  end
end
