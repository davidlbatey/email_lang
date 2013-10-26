class AppConfig
  def self.properties
    @properties ||= load_properties.with_indifferent_access
  end

  def self.load_properties
    YAML.load(File.read('config/app_config.yml'))[Rails.env]
  end

  def self.method_missing(sym, *args, &block)
    property = properties[sym]
    return property unless property.nil?
    super sym, *args, &block
  end
end
