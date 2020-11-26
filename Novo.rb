require 'sinatra'
require 'yaml/store'
require 'sinatra/activerecord'
require './Element.rb'

class Novo < Sinatra::Base
    register Sinatra::ActiveRecordExtension
end

Choices = Hash.new

elements = Element.all

elements.each do |e|
  Choices[e.chave] = e.nome
end

get '/' do
  @title = 'Bem vindo'
  erb :index
end