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

      respond_to do |format|
        if @comment.save
          @beast.rating = @new_rating
          @beast.save
          format.html { redirect_to @beast, notice: 'Comment was successfully created.' }
        else
          # todo chyba bedzie trza ogarnąć jakiegoś ajaxa
          format.html { redirect_to @beast, alert: 'rate must be in range 1-10' }
          # format.html { render :new }
        end
      end

    elsif params[:subject_id] # add comment to subject
      @subject = Subject.find(params[:subject_id])
      @comment = @subject.comments.new(comment_params)
      @comment.user_id = current_user.id

      @new_rating = (@subject.comments.count * @subject.rating + @comment.rate) / (@subject.comments.count + 1)

      respond_to do |format|
        if @comment.save
          @subject.rating = @new_rating
          @subject.save
          format.html { redirect_to @subject, notice: 'Comment was successfully created.' }
        else
          format.html { redirect_to @subject, alert: 'rate must be in range 1-10' }
          # format.html { render :new }
        end
      end
    else
      puts "spierdoliło sie na amen"
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @new_comment_rate = comment_params.fetch(:rate).to_i
    if @comment.beast_id
      @beast = Beast.find(@comment.beast_id)
      @new_rating = (@beast.comments.count * @beast.rating - @comment.rate + @new_comment_rate) / (@beast.comments.count)

      respond_to do |format|
        if @comment.update(comment_params)
          @beast.rating = @new_rating
          @beast.save
          format.html { redirect_to @beast, notice: 'Comment was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    else
      @subject = Subject.find(@comment.subject_id)
      @new_rating = (@subject.comments.count * @subject.rating - @comment.rate.to_i + @new_comment_rate) / (@subject.comments.count)

      respond_to do |format|
        if @comment.update(comment_params)
          @subject.rating = @new_rating
          @subject.save
          format.html { redirect_to @subject, notice: 'Comment was successfully updated.' }
        else
          format.html { render :edit }
        end
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
