class BeastsController < ApplicationController
  before_action :set_beast, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  load_and_authorize_resource


  # GET /beasts
  # GET /beasts.json
  def index
    @beasts = Beast.all
  end

  # GET /beasts/1
  # GET /beasts/1.json
  def show
  end

  # GET /beasts/new
  def new
    @beast = Beast.new
  end

  # GET /beasts/1/edit
  def edit
  end

  # POST /beasts
  # POST /beasts.json
  def create
    @beast = Beast.new(beast_params)
    @beast.rating = 0


    respond_to do |format|
      if @beast.save
        format.html { redirect_to @beast, notice: 'Beast was successfully created.' }
        format.json { render :show, status: :created, location: @beast }
      else
        format.html { render :new }
        format.json { render json: @beast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beasts/1
  # PATCH/PUT /beasts/1.json
  def update
    respond_to do |format|
      if @beast.update(beast_params)
        format.html { redirect_to @beast, notice: 'Beast was successfully updated.' }
        format.json { render :show, status: :ok, location: @beast }
      else
        format.html { render :edit }
        format.json { render json: @beast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beasts/1
  # DELETE /beasts/1.json
  def destroy
    @beast.destroy
    respond_to do |format|
      format.html { redirect_to beasts_url, notice: 'Beast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beast
      @beast = Beast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beast_params
      params.require(:beast).permit(:firstname, :lastname, :pseudo, :degree, :rating, :bio, :image, :subject_ids => [])
    end
end
