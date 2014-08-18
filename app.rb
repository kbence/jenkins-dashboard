require 'sinatra'
require 'httparty'
require 'json'
require 'sinatra/assetpack'
require 'less'

require_relative 'lib/yaml_config'
require_relative 'lib/jenkins/jenkins'
require_relative 'lib/cache'

class App < Sinatra::Base
  register Sinatra::AssetPack

  assets {
    serve '/css', from: 'assets/css'
  }

  def initialize
    super

    @config = YamlConfig.get
    @cache = Cache.new
    @jenkins = Jenkins::Jenkins.new @cache, @config['jenkins']
  end

  get '/' do
    erb :index, :locals => {
        :jobs => @jenkins.jobs
    }
  end
end
