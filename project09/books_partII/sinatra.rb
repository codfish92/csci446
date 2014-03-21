require 'sinatra'
require 'data_mapper'
require_relative 'book'
require 'stringio'
require 'erb'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/books.sqlite3.db")

DataMapper.finalize.auto_upgrade!

get '/' do 
	@books = Book.all
	erb :home
end

post '/' do
	@books = Book.all
	
	@books.sort! { |x, y| eval("x.#{params[:searchParam]}") <=> eval("y.#{params[:searchParam]}")}
	erb :list
end


