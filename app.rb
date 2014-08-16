require 'sinatra'
require 'httparty'
require 'json'
require './lib/yaml_config'
require './lib/jenkins/jenkins'
require 'sinatra/assetpack'
require 'less'

class App < Sinatra::Base
  register Sinatra::AssetPack

  assets {
    serve '/css', from: 'assets/css'
  }

  def initialize
    super

    @config = YamlConfig.get
    @jenkins = Jenkins::Jenkins.new @config['jenkins']
  end

  get '/' do
    erb :index, :locals => {
        :jobs => @jenkins.jobs
    }
  end
end
