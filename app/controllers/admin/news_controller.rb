class Admin::NewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /admin/news
  # GET /admin/news.json
  def index
    @news = News.sorted
  end

  # GET /admin/news/1
  # GET /admin/news/1.json
  def show
  end

  # GET /admin/news/new
  def new
    @news = News.new
    @news.reform_survey_id = params[:reform_survey_id] if params[:reform_survey_id].present?
  end

  # GET /admin/news/1/edit
  def edit
  end

  # POST /admin/news
  # POST /admin/news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug, t: params[:news][:t]), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/news/1
  # PATCH/PUT /admin/news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug, t: params[:news][:t]), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/news/1
  # DELETE /admin/news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to admin_verdicts_url(v: @verdict.slug, t: params[:news][:t]), notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.news', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      permitted = News.globalize_attribute_names + [:verdict_id, :reform_survey_id, :image]
      params.require(:news).permit(*permitted)
    end

end
