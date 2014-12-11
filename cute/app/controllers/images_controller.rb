class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @display_dog = Image.all.map{|x| x if x.img_type == "Dog"}.compact!.sample
    @display_cat = Image.all.map{|x| x if x.img_type == "Cat"}.compact!.sample
    @display_baby = Image.all.map{|x| x if x.img_type == "Baby"}.compact!.sample
    @display_reptile = Image.all.map{|x| x if x.img_type == "Reptile"}.compact!.sample
    @display_horse = Image.all.map{|x| x if x.img_type == "Horse"}.compact!.sample
    @display_hedgehog = Image.all.map{|x| x if x.img_type == "Hedgehog"}.compact!.sample
    @display_bird = Image.all.map{|x| x if x.img_type == "Bird"}.compact!.sample
    @display_rodent = Image.all.map{|x| x if x.img_type == "Rodent"}.compact!.sample
  end

  # GET /images/1
  # GET /images/1.json
  def show
	@post = @image.posts.new
	@image = Image.find(params[:id])
	if @image.total_vote > 0
		@cute_percent = (@image.cute_vote.to_f/@image.total_vote.to_f*100.00).to_i
	else
		@cute_percent = 0
	end
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
     @image = Image.new(image_params)
     @image.cute_vote = 0
     @image.total_vote = 0
	@image.generate_filename
	@image.user = current_user
	@uploaded_io = params[:image][:uploaded_file]
	if @uploaded_io != nil
		File.open(Rails.root.join('public','images',@image.filename), 'wb') do |file|
			file.write(@uploaded_io.read)
		end

		if @image.save
			redirect_to @image, notice: 'Image was successfully created'
		else
			render :new
		end
	else
		@image.destroy
		index
	end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
	@uploaded_io = params[:image][:uploaded_file]
	@image.img_type = params[:img_type]
	if @uploaded_io != nil
		File.open(Rails.root.join('public','images',@image.filename), 'wb') do |file|
			file.write(@uploaded_io.read)
		end

		if @image.save
			redirect_to @image, notice: 'Image was updated'
		else
			render :new
		end
	else
		@image.save
		redirect_to @image, notice: 'Image was updated'
        end
  end

  def yes_vote
	@image = Image.find(params[:id])
	@image.cute_vote = @image.cute_vote + 1
	@image.total_vote = @image.total_vote + 1
	@image.save
	@dice = Image.all.map{|x| x if x.img_type == @image.img_type and x.id != @image.id}.compact!.sample
	if @dice == nil
	redirect_to root_url
	else
	redirect_to @dice
	end
  end

  def no_vote
	@image = Image.find(params[:id])
	@image.total_vote = @image.total_vote + 1
	@image.save
	@dice = Image.all.map{|x| x if x.img_type == @image.img_type and x.id != @image.id}.compact!.sample
	if @dice == nil
	redirect_to root_url
	else
	redirect_to @dice
	end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:filename, :img_type, :cute_vote, :total_vote, :user_id)
    end
end
