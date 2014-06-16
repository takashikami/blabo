class SubjectsController < ApplicationController
  before_action :set_subject, only: [:img, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
    @subjects = @subjects.where(cat: params[:cat]) if params[:cat]
    @subjects = @subjects.where(user_id: params[:user_id]) if params[:user_id]
    @subjects = @subjects.joins(:comments).where(comments:{user_id:params[:comment_user_id]}) if params[:comment_user_id]
    @subjects = @subjects.order(updated_at: :desc)
  end
  def list
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @comment = @subject.comments.new
  end

  # GET /subjects/new
  def new
    @subject = current_user.subjects.new
    @subject.cat = params[:cat].to_i if params[:cat]
  end

  # GET /subjects/1/edit
  def edit
  end

  def img
    data = File.read @subject.pic
    img = MiniMagick::Image.read data
    send_data data, type: img.mime_type, disposition: 'inline'
  end

  # POST /subjects
  # POST /subjects.json
  def create
    file = params[:subject].delete(:file)
    @subject = current_user.subjects.new(subject_params)

    respond_to do |format|
      if file && @subject.save
        @subject.pic = save_image(file, @subject.id)
        @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to list_subjects_url, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    File.unlink @subject.pic rescue 0
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to list_subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:title, :pic, :quote, :cat)
    end

  def save_image(file, n)
    maxw = 640
    image = MiniMagick::Image.read(file.read)

    w = image[:width]
    image.combine_options do |c|
      c.gravity 'center'
      c.crop "#{w}x#{w/4*3}+0+0"
    end if w < image[:height]
    image.resize w > maxw ? maxw : w
    image.quality 70

    shareddir = ENV['USER'] == 'deploy' ? '/data/blabo/shared' : Rails.root.to_path
    filename = shareddir + '/files/' + 'a%08d.'%n + image[:format].to_s.downcase

    image.write(filename)
    filename
  end
end
