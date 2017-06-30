class RubyWeeklyScraper

	attr_accessor :newsletter, :doc

	def initialize(issue_number)
		#everything from class Newsletter comes into this class through the Newsletter.new.
		#all methods connected to @newsletter must match the methods created in the newsletter class
		@newsletter = Newsletter.new
		@newsletter.issue_number = issue_number
		@doc = Nokogiri::HTML(open("http://rubyweekly.com/issues/#{issue_number}"))
	end

	def scrape
		scrape_details
		scrape_articles
		#this instance should have a bunch of article and details
		@newsletter
	end

	def scrape_details

		@newsletter.issue_date = doc.css("table.gowide.lonmo").text.gsub("Issue #{@issue_number} -- ", "").strip
	end

	def scrape_articles
		#the [2..-1] takes out the first 2 elements that are not valid tables to be used
		@doc.search("td[align='left'] table.gowide")[2..-1].each do |article_table|
			#instantiate the article
			#everything from class Article comes into this class through the Article.new.
			a = Article.new
			#scrape the data
			a.author = article_table.css('div:first').text.strip
			a.title = article_table.css('a:first').text.strip
			a.url = article_table.css('a:first').attr('href').text.strip
			a.description = article_table.css('div:last').text.strip

			#adds the article to the newsletter.
			@newsletter.add_article(a)
		end
	end

end

