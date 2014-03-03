#!/usr/bin/ruby


require 'rack'


class Book
	def initialize(bookName, bookAuthor, bookLanguage, bookDate, bookCopies, bookRank)
		@name = bookName
		@author = bookAuthor
		@language = bookLanguage
		@date = bookDate
		@copies = bookCopies
		@rank = bookRank
	end
	def name()
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

class MyGreatRack 
	@books = []
	def initialize()
		#set up vars for other funcs
		bookfile = File.open("books.txt", "r")
		lines = bookfile.readlines()
		#i know this isn't quite the ruby way, but i didn't want any hicups when i was coding
		i= 0
		while i< lines.count-1
			data = lines[i].split(',')
			if @books == nil
				@books = [Book.new(data[0], data[1], data[2], data[3], data[4], i+1)]
			else
				@books.push(Book.new(data[0], data[1], data[2], data[3], data[4], i+1))
			end
			i +=1
		end
		bookfile.close()
	end
	
	def call(env)
		request = Rack::Request.new(env)
		response = Rack::Response.new
		#include header on every page
		File.open("header.html", "r") { |head| response.write(head.read) }
		if request.post? #if you have post data, present table by search param
			sortBooks(request, response, request["searchParam"]) #could just use request, but this is easier for me to read
		else
			case env["PATH_INFO"]
				when /.*?\.css/
					#serve up a css file
					file = env["PATH_INFO"][1..-1]
					return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
				when /\//
					File.open("search.html", "r") { |form| response.write(form.read)}
				when /\/test.*/
					displayBooks(request, response)
				else
					[404, {"Content-Type" => "text/plain"}, ["Error 404 ( . Y . )"]]
				end
		end
		#include footer on every page
		File.open("footer.html", "r") { |foot| response.write(foot.read)}
#
		response.finish
	end	

	def displayBooks(request, response)
		book = Book.new("testName", "tim allen", "english", 145, 200, 1)
		getBooks().sort{ |x, y| x.name <=> y.name }.each {|book| response.write( "#{book.name}, #{book.author}, #{book.language}, #{book.date}, #{book.copies}, #{book.rank}<br>")}
	end
	def sortBooks(request, response, param)
		#write the first part of table
		response.write("<table id='bookTable'><tr><td>Title</td><td>Author</td><td>Language</td><td>Publish Date</td><td>Copies Sold</td><td>Rank</td></tr>")
		if param == "rank"
			#@books should have written in sorted by rank, no need to do any sort
			getBooks().each {|book| response.write("<tr><td>#{book.name}</td><td>#{book.author}</td><td>#{book.language}</td><td>#{book.date}</td><td>#{book.copies}</td><td>#{book.rank}</td></tr>")}
		elsif param == "title"
			#sort by title
			getBooks().sort{ |x, y| x.name <=> y.name }.each {|book| response.write("<tr><td>#{book.name}</td><td>#{book.author}</td><td>#{book.language}</td><td>#{book.date}</td><td>#{book.copies}</td><td>#{book.rank}</td></tr>")}
		elsif param == "author"
			#sort by name
			getBooks().sort{ |x, y| x.author <=> y.author}.each {|book| response.write("<tr><td>#{book.name}</td><td>#{book.author}</td><td>#{book.language}</td><td>#{book.date}</td><td>#{book.copies}</td><td>#{book.rank}</td></tr>")}
		elsif param == "language"
			#sort by language
			getBooks().sort{ |x, y| x.language <=> y.language}.each {|book| response.write("<tr><td>#{book.name}</td><td>#{book.author}</td><td>#{book.language}</td><td>#{book.date}</td><td>#{book.copies}</td><td>#{book.rank}</td></tr>")}
		elsif param == "date"
			#sort by date
			getBooks().sort{ |x, y| x.date <=> y.date}.each {|book| response.write("<tr><td>#{book.name}</td><td>#{book.author}</td><td>#{book.language}</td><td>#{book.date}</td><td>#{book.copies}</td><td>#{book.rank}</td></tr>")}
		elsif param == "copies"
			#sort by copies
			getBooks().sort{ |x, y| x.copies <=> y.copies}.each {|book| response.write("<tr><td>#{book.name}</td><td>#{book.author}</td><td>#{book.language}</td><td>#{book.date}</td><td>#{book.copies}</td><td>#{book.rank}</td></tr>")}
		else
			#this should never happen, lets you know something is wrong
			response.write("<tr><td>Something aint right</td></tr>")
		end
		#close the table
		response.write("</table>") 
	end


	def getBooks()
		return @books
	end

end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run MyGreatRack.new, :Port => 8080

