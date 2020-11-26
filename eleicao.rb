require 'sinatra'
require 'yaml/store'
require 'sinatra/activerecord'
require './Element.rb'

#Choices = {
#  'HAM' => 'Hamburguer',
#  'PIZ' => 'Pizza',
#  'TEM' => 'Temaki',
#  'MAC' => 'Macarrao',
#  'BIF' => 'Arroz, feijao, bife e batata frita',
#}

class Eleicao < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end


Choices = Hash.new

#elements = Element.all

#elements.each do |e|
#  Choices[e.chave] = e.nome
#end

def loadChoices
  elements = Element.all
  elements.each do |e|
    Choices[e.chave] = e.nome
  end
end

#loadChoices

get '/' do
  loadChoices
  @title = 'Bem vindo'
  erb :index
end

post '/cast' do
  @title = 'Obrigado por votar!'
  @vote  = params['vote']
  elemento = Element.find(@vote)
  elemento.votos += 1
  elemento.save
  #@store = YAML::Store.new 'votos.yml'
  #@store.transaction do
  #  @store['votes'] ||= {}
  #  @store['votes'][@vote] ||= 0
  #  @store['votes'][@vote] += 1
  #end
  erb :cast
end

get '/results' do
  @title = 'Resultados até agora:'
  #@store = YAML::Store.new 'votos.yml'
  #@votes = @store.transaction { @store['votes'] }
  @votes = Hash.new
  elements = Element.all
  elements.each do |e|
    @votes[e.chave] = e.votos
  end
  erb :results
end