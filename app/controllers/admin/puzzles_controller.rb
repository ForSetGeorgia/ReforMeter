class Admin::PuzzlesController < ApplicationController
  before_action :set_puzzle, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :load_variables, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/puzzles
  # GET /admin/puzzles.json
  def index
    @puzzles = Puzzle.sorted.include_reforms
  end

  # GET /admin/puzzles/1
  # GET /admin/puzzles/1.json
  def show
  end

  # GET /admin/puzzles/new
  def new
    @puzzle = Puzzle.new
  end

  # GET /admin/puzzles/1/edit
  def edit
  end

  # POST /admin/puzzles
  # POST /admin/puzzles.json
  def create
    @puzzle = Puzzle.new(puzzle_params)

    respond_to do |format|
      if @puzzle.save
        format.html { redirect_to admin_puzzle_path(@puzzle), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/puzzles/1
  # PATCH/PUT /admin/puzzles/1.json
  def update
    respond_to do |format|
      if @puzzle.update(puzzle_params)
        format.html { redirect_to admin_puzzle_path(@puzzle), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/puzzles/1
  # DELETE /admin/puzzles/1.json
  def destroy
    @puzzle.destroy
    respond_to do |format|
      format.html { redirect_to admin_puzzles_url, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.news', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puzzle
      @puzzle = Puzzle.friendly.find(params[:id])
    end

    def load_variables
      @reforms = Reform.active.sorted

      # set the date for the datepicker
      gon.date = @puzzle.date.strftime('%m/%d/%Y %H:%M') if @puzzle && !@puzzle.date.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puzzle_params
      permitted = Puzzle.globalize_attribute_names + [:is_public, :date, :reform_id, :image_ka, :image_en]
      params.require(:puzzle).permit(*permitted)
    end

end
