class InvalidType < StandardError; end
#when we design classes we call them models.
#We dont need to pr0gram everything at once.
class Newsletter
	#Newsletters have articles, issue numbers and issue dates
	#We gove newsletters these attributes
	attr_accessor :issue_number, :issue_date
	attr_reader :articles

	def initialize
		@articles = []
	end

	def articles
		#freeze means the object cannot be changed, cannot add data to it
		#when we run n.articles (n = Newsletter.new) we get back a frozen array. Which mean that no one else can misuse the object and push the wrong type of object
		#Cannot add articles this way, the only way to add an article will be using add_article(article)
		@articles.dup.freeze
	end

	def add_article(article)
		#raise an invalid type error if what is being pushewd is not an Article
		if !article.is_a?(Article)
			raise InvalidType, "must be an Article"
	else
			#otherwise push the article onto the array
			@articles << article
		end
	end

end