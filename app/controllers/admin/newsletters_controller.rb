class Admin::NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]

  # GET /admin/newsletters
  # GET /admin/newsletters.json
  def index
    @newsletters = Newsletter.sorted
  end

  # GET /admin/newsletters/1
  # GET /admin/newsletters/1.json
  # def show
  # end

  # GET /admin/newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /admin/newsletters/1/edit
  def edit
  end

  # POST /admin/newsletters
  # POST /admin/newsletters.json
  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to admin_newsletters_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.newsletter', count: 1)) }
        format.json { render :show, status: :created, location: @newsletter }
      else
        format.html { render :new }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/newsletters/1
  # PATCH/PUT /admin/newsletters/1.json
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to admin_newsletters_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.newsletter', count: 1)) }
        format.json { render :show, status: :ok, location: @newsletter }
      else
        format.html { render :edit }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/newsletters/1
  # DELETE /admin/newsletters/1.json
  def destroy
    @newsletter.destroy
    respond_to do |format|
        format.html { redirect_to admin_newsletters_path, notice: t('shared.msgs.success_destroyed',
                            obj: t('activerecord.models.newsletter', count: 1)) }
      format.json { head :no_content }
    end
  end


  # download all of the emails into a csv file
  def download
    # create file name using event name and map title that were passed in
    filename = "reformeter_newsletter_emails"
    filename << "-#{l Time.now, :format => :file}"

    # csv_data = CSV.generate(col_sep: ',', force_quotes: true) do |csv|
    #   # add header
    #   csv << ["email"]

    #   # data
    #   Newsletter.sorted.each do |row|
    #     csv << [row.email]
    #   end
    # end

    csv_data = Newsletter.to_csv

    respond_to do |format|
      format.csv {
        send_data csv_data,
          :type => 'text/csv; header=present',
          :disposition => "attachment; filename=#{clean_filename(filename)}.csv"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.require(:newsletter).permit(:email)
    end

    # remove bad characters from file name
    def clean_filename(filename)
      filename.gsub(' ', '_').gsub(/[\\ \/ \: \* \? \" \< \> \| \, \. ]/,'')
    end
end
