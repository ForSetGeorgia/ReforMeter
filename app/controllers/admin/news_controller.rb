class Admin::NewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :load_types, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/news
  # GET /admin/news.json
  def index
    @news = News.sorted.include_reforms
  end

  # GET /admin/news/1
  # GET /admin/news/1.json
  def show
  end

  # GET /admin/news/new
  def new
    @news = News.new
  end

  # GET /admin/news/1/edit
  def edit
    set_date
  end

  # POST /admin/news
  # POST /admin/news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to admin_news_path(@news), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        set_date
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/news/1
  # PATCH/PUT /admin/news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to admin_news_path(@news), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.news', count: 1)) }
      else
        set_date
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/news/1
  # DELETE /admin/news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to admin_news_url(@news), notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.news', count: 1)) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      permitted = News.globalize_attribute_names + [:reform_id, :image, :is_public, :date, :video_embed,
        news_slideshows_attributes: [:id, :_destroy, :sort_order, :image, :news_id],
      ]
      params.require(:news).permit(*permitted)
    end

    def load_types

      @reforms = Reform.active.sorted

    end

    # set the date for the datepicker
    def set_date
      gon.date = @news.date.strftime('%m/%d/%Y %H:%M') if !@news.date.nil?
    end

end
