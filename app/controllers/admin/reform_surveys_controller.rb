class Admin::ReformSurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reform_survey, only: [:new, :create, :show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :get_verdict
  before_action :load_reforms, only: [:new, :edit, :create, :update]
  authorize_resource

  # GET /admin/reform_surveys
  # GET /admin/reform_surveys.json
  def index
    @reform_surveys = ReformSurvey.all
  end

  # GET /admin/reform_surveys/1
  # GET /admin/reform_surveys/1.json
  def show

    begin
      @reform = Reform.active.with_color.friendly.find(@reform_survey.reform_id) if @reform_survey

      if @reform.nil? || @verdict.nil? || @reform_survey.nil?
        redirect_to admin_verdicts_path,
                alert: t('shared.msgs.does_not_exist')
      end

      # this is in app controler
      set_reform_show_variables(true)

    rescue ActiveRecord::RecordNotFound  => e
      redirect_to admin_verdicts_path,
                alert: t('shared.msgs.does_not_exist')
    end
    # @reform = Reform.active.with_color.friendly.find(@reform_survey.reform_id)

    # @methodology_government = PageContent.find_by(name: 'methodology_government')
    # @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
    # @news = News.by_reform_verdict(@verdict.id, @reform.id)

    # gon.chart_download_icon = highchart_download_icon
    # gon.change_icons = view_context.change_icons

    # verdict_ids = Quarter.with_reform(@reform.id).recent.pluck(:id)

    # government_time_series = Quarter.reform_survey_data_for_charting(
    #   @reform.id,
    #   type: 'government',
    #   id: 'reform-government-history',
    #   is_published: false,
    #   verdict_ids: verdict_ids
    # )

    # stakeholder_time_series = Quarter.reform_survey_data_for_charting(
    #   @reform.id,
    #   type: 'stakeholder',
    #   id: 'reform-stakeholder-history',
    #   is_published: false,
    #   verdict_ids: verdict_ids
    # )

    # gon.charts = [
    #   government_time_series,
    #   stakeholder_time_series
    # ]

    # if @reform_survey.present?
    #   [
    #     {
    #       id: 'reform-government-overall',
    #       color: government_time_series[:color],
    #       title: I18n.t('shared.categories.overall'),
    #       score: @reform_survey.government_overall_score.to_f,
    #       change: @reform_survey.government_overall_change
    #     }, {
    #       id: 'reform-government-institutional-setup',
    #       title: I18n.t('shared.categories.initial_setup'),
    #       score: @reform_survey.government_category1_score.to_f,
    #       change: @reform_survey.government_category1_change
    #     }, {
    #       id: 'reform-government-capacity-building',
    #       title: I18n.t('shared.categories.capacity_building'),
    #       score: @reform_survey.government_category2_score.to_f,
    #       change: @reform_survey.government_category2_change
    #     }, {
    #       id: 'reform-government-infrastructure-budgeting',
    #       title: I18n.t('shared.categories.infastructure_budgeting'),
    #       score: @reform_survey.government_category3_score.to_f,
    #       change: @reform_survey.government_category3_change
    #     }, {
    #       id: 'reform-government-legislation-regulations',
    #       title: I18n.t('shared.categories.legislation_regulation'),
    #       score: @reform_survey.government_category4_score.to_f,
    #       change: @reform_survey.government_category4_change
    #     }, {
    #       id: 'reform-stakeholder-overall',
    #       color: government_time_series[:color],
    #       title: t('shared.categories.overall'),
    #       score: @reform_survey.stakeholder_overall_score.to_f,
    #       change: @reform_survey.stakeholder_overall_change
    #     }, {
    #       id: 'reform-stakeholder-performance',
    #       color: government_time_series[:color],
    #       title: t('shared.categories.performance'),
    #       score: @reform_survey.stakeholder_category1_score.to_f,
    #       change: @reform_survey.stakeholder_category1_change
    #     # }, {
    #     #   id: 'reform-stakeholder-goals',
    #     #   color: government_time_series[:color],
    #     #   title: t('shared.categories.goals'),
    #     #   score: @reform_survey.stakeholder_category2_score.to_f,
    #     #   change: @reform_survey.stakeholder_category2_change
    #     # }, {
    #     }, {
    #       id: 'reform-stakeholder-progress',
    #       color: government_time_series[:color],
    #       title: t('shared.categories.progress'),
    #       score: @reform_survey.stakeholder_category2_score.to_f,
    #       change: @reform_survey.stakeholder_category2_change
    #     }, {
    #       id: 'reform-stakeholder-outcome',
    #       color: government_time_series[:color],
    #       title: t('shared.categories.outcome'),
    #       score: @reform_survey.stakeholder_category3_score.to_f,
    #       change: @reform_survey.stakeholder_category3_change
    #     }
    #   ].each { |chart| gon.charts << chart }
    # end

    # @external_indicators = @reform.external_indicators.published.sorted.with_time_periods.map do |ext_ind|
    #   ext_ind.format_for_charting
    # end

    # gon.charts += @external_indicators
  end

  # GET /admin/reform_surveys/new
  def new
    # if all reforms are already evaluated, stop
    if @reforms.length > 0 && @survey_reforms.length > 0
      found_all = true
      @reforms.each do |reform|
        found_all = @survey_reforms.select{|x| x.reform_id == reform.id}.length > 0
        break if !found_all
      end
      if found_all
        redirect_to admin_verdicts_path(v: @verdict.slug, t: 'reform_survey'),
                alert: t('shared.msgs.all_reform_surveys_exist', verdict: @verdict.time_period)
      end
    end
  end

  # GET /admin/reform_surveys/1/edit
  def edit
    set_date
  end

  # POST /admin/reform_surveys
  # POST /admin/reform_surveys.json
  def create
    # @reform_survey = ReformSurvey.new(reform_survey_params)

    respond_to do |format|
      if @reform_survey.save
        format.html { redirect_to admin_verdict_reform_survey_path(verdict_id: @verdict.slug, id: @reform_survey.id), notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
      else
        set_date
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/reform_surveys/1
  # PATCH/PUT /admin/reform_surveys/1.json
  def update
    respond_to do |format|
      if @reform_survey.update(reform_survey_params)
        format.html { redirect_to admin_verdict_reform_survey_path(verdict_id: @verdict.slug, id: @reform_survey.id), notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
      else
        set_date
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/reform_surveys/1
  # DELETE /admin/reform_surveys/1.json
  def destroy
    @reform_survey.destroy
    respond_to do |format|
      format.html { redirect_to admin_verdicts_url(v: @verdict.slug, t: 'reform_survey'), notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
    end
  end


  def publish
    @reform_survey.is_public = true
    respond_to do |format|
      if @reform_survey.save
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug, t: 'reform_survey'), notice: t('shared.msgs.success_published',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
      else
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug, t: 'reform_survey'), alert: t('shared.msgs.fail_published',
                            obj: t('activerecord.models.reform_survey', count: 1),
                            msg: @verdict.errors.full_messages.join('; ')) }
      end
    end
  end

  def unpublish
    @reform_survey.is_public = false
    respond_to do |format|
      if @reform_survey.save
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug, t: 'reform_survey'), notice: t('shared.msgs.success_unpublished',
                            obj: t('activerecord.models.reform_survey', count: 1)) }
      else
        format.html { redirect_to admin_verdicts_path(v: @verdict.slug, t: 'reform_survey'), alert: t('shared.msgs.fail_unpublished',
                            obj: t('activerecord.models.reform_survey', count: 1),
                            msg: @verdict.errors.full_messages.join('; ')) }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reform_survey
      @reform_survey = params[:action] == 'new' ? ReformSurvey.new : params[:action] == 'create' ? @reform_survey = ReformSurvey.new(reform_survey_params) : ReformSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reform_survey_params
      permitted = ReformSurvey.globalize_attribute_names + [
        :verdict_id, :reform_id, :report_en, :report_ka, :time_period, :is_public,
        :delete_report_en, :delete_report_ka,
        :government_overall_score, :government_category1_score, :government_category2_score, :government_category3_score, :government_category4_score,
        :stakeholder_overall_score, :stakeholder_category1_score, :stakeholder_category2_score, :stakeholder_category3_score
      ]
      params.require(:reform_survey).permit(*permitted)
    end

    def load_reforms
      # ge all reforms
      @reforms = Reform.active.sorted

      # get all reforms that already have a survey for this verdict
      @survey_reforms = ReformSurvey.in_verdict(@verdict.id)
      @survey_reforms = @survey_reforms.not_in_reform(@reform_survey.reform_id) if @reform_survey.reform_id
    end

    # set the date for the datepicker
    def set_date
      gon.time_period = @reform_survey.time_period.strftime('%m/%d/%Y %H:%M') if !@reform_survey.time_period.nil?
    end
end
