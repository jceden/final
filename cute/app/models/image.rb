class Image < ActiveRecord::Base
  belongs_to :user
  has_many :posts
	def generate_filename
		self.filename = (0...15).map { (65 + rand(26)).chr }.join + ".jpg"
		if Image.find_by(filename: self.filename) !=nil
		generate_filename
		end
	end
end
