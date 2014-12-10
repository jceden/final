class Image < ActiveRecord::Base
  belongs_to :user
  has_many :posts
	def generate_filename
		self.filename = (0...15).map { (65 + rand(26)).chr }.join + ".jpg"
		if Image.find_by(filename: self.filename) !=nil
		generate_filename
		end
	end
	def percent_cute
		(self.cute_vote.to_f/self.total_vote.to_f).to_f
	end

	def random_self
		(Image.all - self).map{|image| image if image.img_type == self.img_type and image.id != self.id}.compact!.sample
	end

	def rando_dog
		(Image.all).map{|image| image if image.img_type == "Dog"}.compact!.sample
	end
end
