class Book < ActiveRecord::Base
	has_many :ratings
	has_many :notes
	has_many :favequotes
	has_many :lityears
	has_many :users, through: :lityears

	accepts_nested_attributes_for :notes, :ratings, :favequotes, :lityears


	def self.search(query)
    	where('title LIKE :query', :query => "%#{query}%")
  	end

end
