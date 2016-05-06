# Non-resource pages
class RootController < ApplicationController
  def index
    @home_page_about = PageContent.find_by(name: 'home_page_about')
  end

  def about
    @about_text = PageContent.find_by(name: 'about_text')
    @methodology_expert = PageContent.find_by(name: 'methodology_expert')
    @methodology_government = PageContent.find_by(name: 'methodology_government')
    @methodology_stakeholder = PageContent.find_by(name: 'methodology_stakeholder')
  end

  def download_data_and_reports
    @download_text = PageContent.find_by(name: 'download_text')
    @download_expert_text = PageContent.find_by(name: 'download_expert_text')
    @download_reform_text = PageContent.find_by(name: 'download_reform_text')
    @download_external_indicator_text = PageContent.find_by(name: 'download_external_indicator_text')
    @download_report_text = PageContent.find_by(name: 'download_report_text')
  end

  def reforms
    @reform_text = PageContent.find_by(name: 'reform_text')


  end

  def reform_show

  end

  def experts
    @expert_text = PageContent.find_by(name: 'expert_text')
    @methodology_expert = PageContent.find_by(name: 'methodology_expert')

    @quarters = Quarter.published.recent.with_expert_survey
  end

  def expert_show
    begin
      @quarter = Quarter.published.with_expert_survey.friendly.find(params[:id])
      @active_quarters = Quarter.active_quarters_array
      @methodology_expert = PageContent.find_by(name: 'methodology_expert')

      if @quarter.nil?
        redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
      end
      
    rescue ActiveRecord::RecordNotFound  => e
      redirect_to experts_path,
                alert: t('shared.msgs.does_not_exist')
    end    
  end

end
