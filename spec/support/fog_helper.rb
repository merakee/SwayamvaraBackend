module FogHelpers
  Fog.mock!
  Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')
  connection = Fog::Storage.new(:provider => 'AWS')
  connection.directories.create(:key => 'swayamvarabackend-dev-freelogue')
end
