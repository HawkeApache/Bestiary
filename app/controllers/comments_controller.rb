class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  load_and_authorize_resource


  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json

  def create
    if params[:beast_id] # add comment to beast
      @beast = Beast.find(params[:beast_id])
      @comment = @beast.comments.new(comment_params)
      @comment.user_id = current_user.id

      @new_rating = (@beast.comments.count * @beast.rating + @comment.rate) / (@beast.comments.count + 1)
      @beast.rating = @new_rating
      @beast.save

      respond_to do |format|
        if @comment.save
          format.html { redirect_to @beast, notice: 'Comment was successfully created.' }
        else
          # todo chyba bedzie trza ogarnąć jakiegoś ajaxa
          format.html { redirect_to @beast, alert: 'rate must be in 1-10' }
          # format.html { render :new }
        end
      end


    elsif params[:subject_id] # add comment to subject
      @subject = Subject.find(params[:subject_id])
      @comment = @subject.comments.new(comment_params)
      @comment.user_id = current_user.id

      @new_rating = (@subject.comments.count * @subject.rating + @comment.rate) / (@subject.comments.count + 1)
      @subject.rating = @new_rating
      @subject.save

      respond_to do |format|
        if @comment.save
          format.html { redirect_to @subject, notice: 'Comment was successfully created.' }
        else
          format.html { render :new }
          format.json { render json: @subject.errors, status: :unprocessable_entity }
        end
      end
    else
      puts "spierdoliło sie na amen"
    end
  end


  #todo updade i delete
  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  # todo problems with url??
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:rate, :message, :user_id, :beast_id, :subject_id)
    end
end
