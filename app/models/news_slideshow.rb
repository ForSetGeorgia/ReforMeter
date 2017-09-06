class NewsSlideshow < ActiveRecord::Base
  #######################
  ## ATTACHED FILE
  has_attached_file :image,
                    :url => "/system/news_slideshow/:id/:style.:extension",
                    :styles => {
                        :'360x200' => {:geometry => "360x200>"},
                        :'90x50' => {:geometry => "90x50>"}
                    },
                    :convert_options => {
                      :'360x200' => '-quality 85',
                      :'90x50' => '-quality 85'
                    }

  #######################
  ## RELATIONSHIPS
  belongs_to :news

  #######################
  ## VALIDATIONS
  validates :sort_order, presence: :true
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SCOPES
  scope :sorted, -> { order(sort_order: :asc) }

end
