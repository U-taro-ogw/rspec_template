module RequestSpecHelper
  def json_response
    JSON.parse(response.body).with_indifferent_access
  end

  def load_json(file_path)
    File.read("#{Rails.root}/spec/stubs/#{file_path}")
  end
end
