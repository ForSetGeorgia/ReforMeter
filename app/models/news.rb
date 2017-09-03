# == Schema Information
#
# Table name: news
#
#  id                 :integer          not null, primary key
#  reform_id          :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_public          :boolean          default(FALSE)
#  date               :date
#  media_type         :integer
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
  translates :title, :content, :url, :summary, :video_embed,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :reform

  #######################
  ## CONSTANTS
  MEDIA_TYPES = {video: 1, slideshow: 2}

  #######################
  ## VALIDATIONS
  # reform_id is optional because without it, it means it is for expert survey
  validates :title, :summary, :date, presence: :true
  validates_format_of :url, :with => URI::regexp(%w(http https)),
    unless: Proc.new { |x| x.url.blank? }
  validates :media_type, inclusion: { in: MEDIA_TYPES.values },
    unless: Proc.new { |x| x.media_type.blank? }
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :sorted, -> {with_translations(I18n.locale).order(date: :desc, title: :asc)}
  scope :include_reforms, -> {includes :reform}

  def self.by_reform(reform_id)
    where(reform_id: reform_id)
  end


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
