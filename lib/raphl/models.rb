Dir.glob(File.join(File.dirname(__FILE__), "models/**/*.rb")).each do |model|
  require model
end
