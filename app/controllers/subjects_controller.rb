class SubjectsController < ApplicationController
  before_action :set_subject, only: [:img, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :img, :list]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
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
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  def img
    send_data File.read(filename(@subject)), type: 'image/jpeg', disposition: 'inline'
  end

  # POST /subjects
  # POST /subjects.json
  def create
    file = params[:subject].delete(:file)
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if file && @subject.save
        @subject.pic = 'a%08d.jpg'%@subject.id
        File.open(filename(@subject), 'wb'){|jpg| jpg.write(file.read)}
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
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
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
    File.unlink filename(@subject) rescue 0
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
      params.require(:subject).permit(:title, :pic, :quote)
    end

  def filename(subject)
    if ENV['USER'] == 'deploy'
      shareddir = '/data/blabo/shared'
    else
      shareddir = Rails.root.to_path
    end
    shareddir + '/files/' + subject.pic
  end
end
