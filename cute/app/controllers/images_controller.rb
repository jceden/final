class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
	@post = @image.posts.new
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

  def yes_vote
	@image = Image.find(params[:id])
	@dice = Image.all
	@image.increment!(:cute_vote, by = 1)
	@image.total_vote = @image.total_vote + 1
	@image.save
	redirect_to image_path(image)
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
      params.require(:image).permit(:filename, :cute_vote, :total_vote, :user_id)
    end
end
