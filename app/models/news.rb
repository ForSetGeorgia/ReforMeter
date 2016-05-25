class News < ActiveRecord::Base
  #######################
  ## ATTACHED FILE
  has_attached_file :image,
                    :url => "/system/news/:id/:style.:extension",
                    :styles => {
                        :'360x200' => {:geometry => "360x200#"}
                    },
                    :convert_options => {
                      :'360x200' => '-quality 85'
                    }

  #######################
  ## TRANSLATIONS

  translates :title, :content, :url, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  belongs_to :reform
  belongs_to :quarter


  #######################
  ## VALIDATIONS
  validates :quarter_id, :title, :url, presence: :true
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SCOPES
  scope :sorted, -> {order(title: :asc)}

  # get news for a quarter and reform
  def self.by_expert_quarter(quarter_id)
    by_reform_quarter(quarter_id, nil)
  end

  # get news for a quarter and reform
  def self.by_reform_quarter(quarter_id, reform_id)
    where(quarter_id: quarter_id, reform_id: reform_id)
  end
end