module RequestSpecHelper
  def json_data
    JSON.parse(response.body, symbolize_names: true)
  end
end
