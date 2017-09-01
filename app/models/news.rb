# == Schema Information
#
# Table name: news
#
#  id                 :integer          not null, primary key
#  quarter_id         :integer
#  reform_id          :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  reform_survey_id   :integer
#  verdict_id         :integer
#

class News < AddMissingTranslation
  #######################
  ## ATTACHED FILE
  has_attached_file :image,
                    :url => "/system/news/:id/:style.:extension",
                    :styles => {
                        :'360x200' => {:geometry => "360x200#"},
                        :'90x50' => {:geometry => "90x50#"}
                    },
                    :convert_options => {
                      :'360x200' => '-quality 85',
                      :'90x50' => '-quality 85'
                    }

  #######################
  ## TRANSLATIONS

  translates :title, :content, :url, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :reform


  #######################
  ## VALIDATIONS
  # reform_id is optional because without it, it means it is for expert survey
  validates :title, :url, presence: :true
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SCOPES
  scope :sorted, -> {with_translations(I18n.locale).order(title: :asc)}
  scope :for_verdict, -> {where(reform_survey_id: nil)}
  scope :for_reform_survey, -> {where.not(reform_survey_id: nil)}


  #######################
  #######################
  private

  # def has_required_translations?(trans)
  #   trans.title.present?
  # end

  # def add_missing_translations(default_trans)
  #   self.title = default_trans.title if self["title_#{Globalize.locale}"].blank?
  # end

  def required_translation_fields
    return ['title']
  end

end
