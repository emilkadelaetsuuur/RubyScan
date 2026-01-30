require 'httparty'
require 'json'
require_relative 'config'

class VTClient
  include HTTParty
  base_uri BASE_URL
  headers "x-apikey" => API_KEY

  def self.scan_url(url)
    response = post("/urls", body: { url: url })
    JSON.parse(response.body)
  end

  def self.scan_hash(hash)
    response = get("/files/#{hash}")
    JSON.parse(response.body)
  end

  def self.upload_file(path)
    file = File.open(path)

    response = post(
      "/files",
      body: { file: file },
      headers: { "Content-Type" => "multipart/form-data" }
    )

    file.close
    JSON.parse(response.body)
  end

	def self.get_analysis(id)
  response = get("/analyses/#{id}")
  JSON.parse(response.body)
end
end
