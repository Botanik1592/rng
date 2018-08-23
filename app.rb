require 'rubygems'
require 'sinatra'
require 'sinatra/form_helpers'
require 'sinatra/activerecord'
require 'byebug'
require 'pry-byebug'
require 'pry-doc'
require 'pry-rails'
require 'pry-remote'
require 'net/ftp'

configure :development do
  set :database, {adapter: 'postgresql', encoding: 'unicode', database: 'telegram_bot_test_dev', pool: 2, host: ENV['FTP_HOST'], port: 5432, username: ENV['FTP_USER'], password: ENV['FTP_PASS']}
end

configure :production do
  set :database, {adapter: 'postgresql', encoding: 'unicode', database: 'telegram_bot_test_prod', pool: 2, host: ENV['FTP_HOST'], port: 5432, username: ENV['FTP_USER'], password: ENV['FTP_PASS']}
end

class Book < ActiveRecord::Base
  belongs_to :author
end

class Author < ActiveRecord::Base
  has_many :books
end

class Mix < ActiveRecord::Base
end

get '/' do
  if params[:author]
    @author = Author.find(params[:author].to_i)
    erb :author
  else
    erb :index
  end
end

post '/search' do
  book_str = ""
  a_str = ""

  search_data = params[:ss].strip.downcase.split(' ')

  search_data.each_with_index do |word, i|
    book_str = book_str + "search_field ILIKE '%#{word}%'"
    a_str = a_str + "search_name ILIKE '%#{word}%'"

    if i < search_data.size - 1
      book_str = book_str + " AND "
      a_str = a_str + " AND "
    end
  end

  @authors = Author.where(a_str)
  @books = Mix.where(book_str)
  erb :index
end

get '/download' do
  book = Book.find(params[:book].to_i)
  ftp = Net::FTP.new('188.243.135.145')
  ftp.login
  ftp.getbinaryfile("#{book.filename}", "public/#{book.filename}")
  send_file "public/#{book.filename}", :type => 'application/zip',
                                       :disposition => 'attachment',
                                       :filename => book.filename,
                                       :stream => false
end
