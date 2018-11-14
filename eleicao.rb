require 'sinatra'
require 'yaml/store'

Choices = {
  'HAM' => 'Hamburguer',
  'PIZ' => 'Pizza',
  'TEM' => 'Temaki',
  'MAC' => 'Macarrao',
  'BIF' => 'Arroz, feijao, bife e batata frita',
}

get '/' do
  @title = 'Bem vindo'
  erb :index
end

post '/cast' do
  @title = 'Obrigado por votar!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votos.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Resultados até agora:'
  @store = YAML::Store.new 'votos.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end