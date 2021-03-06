require 'rubygems'
require 'sinatra'
require 'sinatra/form_helpers'
require 'sinatra/activerecord'
require 'net/ftp'

configure :production do
  set :database, {adapter: 'postgresql', encoding: 'unicode', database: 'rng_prod', pool: 2, host: ENV['DB_HOST'], port: 5432, username: ENV['DB_USER'], password: ENV['DB_PASS']}
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
    @popular_books = Book.where("d_count > 0").order('d_count desc').limit(10)
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
  ftp = Net::FTP.new(ENV['FTP_HOST'])
  ftp.login(ENV['FTP_USER'], ENV['FTP_PASS'])
  begin
    ftp.getbinaryfile("#{book.filename}", "public/#{book.filename}")
    book.update(d_count: book.d_count+1)
    send_file "public/#{book.filename}", :type => 'application/zip',
                                         :disposition => 'attachment',
                                         :filename => book.filename,
                                         :stream => false
  rescue
    book.destroy
    Mix.find_by(book_id: "#{params[:book]}").destroy
    p "Файл с этой книгой в данный момент недоступен. Вернитесь назад и попробуйте другой."
  end
end
