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
#  slug               :string(255)
#

class News < AddMissingTranslation
  #######################
  ## ATTACHED FILE
  has_attached_file :image,
                    :url => "/system/news/:id/:style.:extension",
                    :styles => {
                      :'poster' => {:geometry => "1280x800#"},
                      :'share' => {:geometry => "1200x628#"},
                      :'thumbnail' => {:geometry => "360x270#"}
                    },
                    :convert_options => {
                      :'poster' => '-quality 85',
                      :'share' => '-quality 85',
                      :'thumbnail' => '-quality 85'
                    }

  #######################
  ## TRANSLATIONS
  translates :title, :content, :url, :summary, :slug,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :reform
  has_many :news_slideshows, dependent: :destroy
  accepts_nested_attributes_for :news_slideshows, :reject_if => lambda { |x| x[:image].blank? && x[:id].blank?}, allow_destroy: true

  #######################
  ## VALIDATIONS
  validates :title, :summary, :date, presence: :true
  validates_format_of :url, :with => URI::regexp(%w(http https)),
    unless: Proc.new { |x| x.url.blank? }
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :slug_text, use: [:globalize, :history, :slugged]

  # the slug text is the format: title - date
  def slug_text
    "#{self.title} - #{I18n.l(self.date)}"
  end

  # for genereate friendly_id
  def should_generate_new_friendly_id?
#    name_changed? || super
    super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_url
  end

  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :sorted, -> {with_translations(I18n.locale).order(date: :desc, title: :asc)}
  scope :include_reforms, -> {includes :reform}
  scope :include_slideshows, -> {includes :news_slideshows}

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
