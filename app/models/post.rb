class Post < ActiveRecord::Base
	before_create :begin_like
	has_many :comments #uno amuchos coments
	scope :search, lambda { |search_word| where('posts.text LIKE ?', "%#{search_word}%") }
	def begin_like
		self.like=0
	end
end
