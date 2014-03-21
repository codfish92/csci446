#!/usr/bin/ruby

#i require a good rack
require 'rack'

require 'sqlite3'
require 'erb'

#define a book class so data can be easily grouped
class Book
	def initialize(bookName, bookAuthor, bookLanguage, bookDate, bookCopies, bookRank)
		@name = bookName
		@author = bookAuthor
		@language = bookLanguage
		@date = bookDate
		@copies = bookCopies
		@rank = bookRank
	end
	#accessors for each instance var
	def title()
		@name
	end
	def author()
		@author
	end
	def language()
		@language
	end
	def date()
		@date
	end
	def copies()
		@copies
	end
	def rank()
		@rank
	end

end

class BookList
	attr_accessor :book

	def initialize(books, search)
		@books = books
		@search = search
	end

	def render()
		renderer.result(binding)
	end
	def get_binding() 
		binding
	end


end

class MyGreatRack 


	def initialize()
		@bookList = []
		#set up book array for sort function
		db = SQLite3::Database.new("books.sqlite3.db")
		rows = db.execute("select * from Books") do  |row| 
			@bookList.push(Book.new(row[1], row[2], row[3], row[4], row[5], row[0]))
		end



	end

	
	def call(env)
		request = Rack::Request.new(env)
		response = Rack::Response.new
		#include header on every page
		File.open("header.html", "r") { |head| response.write(head.read) }
		if request.post? #if you have post data, present table by search param
			@list = BookList.new(@bookList, request["searchParam"])
			sortBooks(request, response, request["searchParam"]) #could just use request, but this is easier for me to read
		else
			case env["PATH_INFO"]
				#load any css file
				when /.*?\.css/
					#serve up a css file
					file = env["PATH_INFO"][1..-1]
					return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
				#when you go to they page without any extension ie 127.0.0.1:8080/
				when /\//
					derp = ERB.new(File.read("search.html.erb"))
					response.write(derp.result())
				#for testing only, if you go to localhost:8080/test you should see all the books
				when /\/test/
					@list = BookList.new(@bookList)
					displayBooks(request, response)
				#something is very wrong
				else
					[404, {"Content-Type" => "text/plain"}, ["Error 404 ( . Y . )"]]
				end
		end
		#include footer on every page
		File.open("footer.html", "r") { |foot| response.write(foot.read)}
#
		response.finish
	end	

	#test function, left it in just cuz
	def displayBooks(request, response)
		renderer = ERB.new(File.read("list.html.erb"))
		response.write("<h1>Testing!!!</h1>")
		response.write(renderer.result(@list.get_binding))
	end
	def sortBooks(request, response, param)
		renderer = ERB.new(File.read("list.html.erb"))
		response.write(renderer.result(@list.get_binding))
	end

	#accesor of instance var
	def getBooks()
		return @bookList
	end

end

#if you don't include this, you can't ctrl-c webrick
Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}
#run on localhost with the port 8080.
Rack::Handler::WEBrick.run MyGreatRack.new, :Port => 8080

