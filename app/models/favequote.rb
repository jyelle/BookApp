class Favequote < ActiveRecord::Base
	belongs_to :book
	belongs_to :users
end
