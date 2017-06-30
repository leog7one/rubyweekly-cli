class RubyWeeklyController

	#when it starts
	def initialize
		puts "Welcome to RubyWeekly!"

		s = RubyWeeklyScraper.new(355)
		@newsletter = s.scrape
	end

#Gets called on start up from the rubyweekly file in bin
	def call
		input = nil
		while input != "exit"
			puts "What would you like to do?"
			input = gets.strip
			case input
			when "list"
				list_articles
			when "exit"
				puts "goodbye"
				break
			else
				#open web browser with the url of the article
				system("open #{@newsletter.articles[input.to_i-1].url}")
			end
		end
	end

		def list_articles
			@newsletter.articles.each.with_index(1) do |a,i|
			puts "#{i}. #{a.title}"
		end
	end

end