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
  ## VALIDATIONS
  validates :title, :summary, :date, :embed_code, presence: :true

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


end
