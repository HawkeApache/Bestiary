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
          format.html { redirect_to @beast, notice: 'Komentarz został dodany' }
        else
          format.html { redirect_to @beast, alert: 'Komentarz NIE może zawierać przekleństw!' }
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
          format.html { redirect_to @subject, notice: 'Komentarz został dodany' }
        else
          format.html { redirect_to @subject, alert: 'Komentarz NIE może zawierać przekleństw!' }
        end
      end
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @new_comment_rate = comment_params.fetch(:rate).to_i
    if @comment.beast_id
      @beast = @comment.beast
      @new_rating = (@beast.comments.count * @beast.rating - @comment.rate + @new_comment_rate) / (@beast.comments.count)

      respond_to do |format|
        if @comment.update(comment_params)
          @beast.rating = @new_rating
          @beast.save
          format.html { redirect_to @beast, notice: 'Zmiany zostały zapisane' }
        else
          format.html { render :edit }
        end
      end
    else
      @subject = @comment.subject
      @new_rating = (@subject.comments.count * @subject.rating - @comment.rate.to_i + @new_comment_rate) / (@subject.comments.count)

      respond_to do |format|
        if @comment.update(comment_params)
          @subject.rating = @new_rating
          @subject.save
          format.html { redirect_to @subject, notice: 'Zmiany zostały zapisane' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @comment.beast_id
      @beast = @comment.beast
      @new_rating = (@beast.comments.count * @beast.rating - @comment.rate) / (@beast.comments.count - 1)
      @beast.rating = @new_rating >= 0 ? @new_rating : 0
      @beast.save
    else
      @subject = @comment.subject
      @new_rating = (@subject.comments.count * @subject.rating - @comment.rate) / (@subject.comments.count - 1)
      @subject.rating = @new_rating >= 0 ? @new_rating : 0
      @subject.save
    end

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @beast || @subject, notice: 'Komentarz został usunięty' }
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
