require 'sinatra'
require 'httparty'
require 'json'
require 'sinatra/assetpack'
require 'less'

require_relative 'lib/yaml_config'
require_relative 'lib/jenkins/jenkins'
require_relative 'lib/cache'

DEFAULT_SKIN = 'vader'

class App < Sinatra::Base
  register Sinatra::AssetPack

  assets {
    serve '/css', from: 'assets/css'
  }

  def initialize
    super

    @config = YamlConfig.get
    @cache = Cache.new
    @jenkins = Jenkins::Jenkins.new @cache, @config['jenkins', {}]
  end

  def skin
    @config['appearance.theme', DEFAULT_SKIN]
  end

  get '/' do
    erb :index, :locals => {
        :skin => skin,
        :jobs => @jenkins.jobs
    }
  end
end
