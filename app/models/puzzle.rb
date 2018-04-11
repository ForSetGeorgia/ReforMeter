class Puzzle < ActiveRecord::Base

  #######################
  ## RELATIONSHIPS
  belongs_to :reform

  #######################
  ## TRANSLATIONS
  translates :title, :content, :summary, :slug, :embed_code,
              :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## ATTACHED FILE
  has_attached_file :image_en,
                    :url => "/system/puzzles/:id/en/:style/:basename.:extension",
                    :styles => {
                      :'share' => {:geometry => "1200x728#"},
                      :'poster' => {:geometry => "360x218.4#"},
                      :'thumbnail' => {:geometry => "150x91#"}
                    },
                    :convert_options => {
                      :'poster' => '-quality 85',
                      :'share' => '-quality 85',
                      :'thumbnail' => '-quality 85'
                    },
                    :use_timestamp => false

  has_attached_file :image_ka,
                    :url => "/system/puzzles/:id/ka/:style/:basename.:extension",
                    :styles => {
                      :'share' => {:geometry => "1200x728#"},
                      :'poster' => {:geometry => "360x218.4#"},
                      :'thumbnail' => {:geometry => "150x91#"}
                    },
                    :convert_options => {
                      :'poster' => '-quality 85',
                      :'share' => '-quality 85',
                      :'thumbnail' => '-quality 85'
                    },
                    :use_timestamp => false

  #######################
  ## VALIDATIONS
  validates :title, :summary, :date, :embed_code, presence: :true
  validates_attachment :image_en,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }
  validates_attachment :image_ka,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SLUG DEFINITION (friendly_id)

  extend FriendlyId
  friendly_id :slug_text, use: [:globalize, :history, :slugged]

  # the slug text is the format: title - date
  def slug_text
    "#{self.title} - #{I18n.l(self.date) if self.date.present?}"
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
  scope :with_title, -> {with_translations(I18n.locale).where('puzzle_translations.title is not null and puzzle_translations.title != ""') }
  scope :include_reforms, -> {includes :reform}

  #######################
  ## METHODS

  def image(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? image_en : image_ka
  end



end
