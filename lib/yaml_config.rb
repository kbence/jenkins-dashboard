require 'yaml'

class YamlConfig
  def self.load(filename)
    self.new(YAML.load_file filename)
  end

  def self.get()
    @@config ||= load("#{__dir__}/../config.yml")
  end

  def initialize(config)
    @config = config
  end

  def [] (str, default=NIL)
    conf = @config

    str.to_s.split('.').each do |part|
      if conf.key? part
        conf = conf[part]
      else
        return default
      end
    end

    conf
  end
end
