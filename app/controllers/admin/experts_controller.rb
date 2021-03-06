class Admin::ExpertsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expert, only: [:show, :edit, :update, :destroy, :up, :down]
  before_action :load_types, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/experts
  # GET /admin/experts.json
  def index
    @experts = Expert.sorted.with_reforms
  end

  # GET /admin/experts/1
  # GET /admin/experts/1.json
  def show
  end

  # GET /admin/experts/new
  def new
    @expert = Expert.new
  end

  # GET /admin/experts/1/edit
  def edit
  end

  # POST /admin/experts
  # POST /admin/experts.json
  def create
    @expert = Expert.new(expert_params)

    respond_to do |format|
      if @expert.save
        format.html { redirect_to admin_experts_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.expert', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/experts/1
  # PATCH/PUT /admin/experts/1.json
  def update
    respond_to do |format|
      if @expert.update(expert_params)
        format.html { redirect_to admin_experts_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.expert', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/experts/1
  # DELETE /admin/experts/1.json
  def destroy
    @expert.destroy
    respond_to do |format|
      format.html { redirect_to admin_experts_url, notice: t('shared.msgs.success_destroyed',
                              obj: t('activerecord.models.expert', count: 1))}
    end
  end

  # move the expert up
  def up
    @expert.move_higher
    render json: nil , status: :created
  end

  # move the expert down
  def down
    @expert.move_lower
    render json: nil , status: :created
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expert
      @expert = Expert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expert_params
      permitted = Expert.globalize_attribute_names + [:avatar, :is_active, :expert_type, :reform_id]
      params.require(:expert).permit(*permitted)
    end

    # create array of expert types to load the form fields
    def load_types
      @expert_types = []
      Expert::EXPERT_TYPES.each do |key,value|
        @expert_types << [I18n.t("shared.expert_types.#{key}"), value]
      end
      @expert_types.sort_by!{|x| x[0]}

      @reforms = Reform.active.sorted

    end
end
