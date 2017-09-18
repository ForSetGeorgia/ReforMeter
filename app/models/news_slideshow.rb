# == Schema Information
#
# Table name: news_slideshows
#
#  id                 :integer          not null, primary key
#  news_id            :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  sort_order         :integer          default(1)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class NewsSlideshow < ActiveRecord::Base
  #######################
  ## ATTACHED FILE
  has_attached_file :image,
                    :url => "/system/news_slideshow/:id/:style.:extension",
                    :styles => {
                      :'poster' => {:geometry => "1280x800#"},
                      :'thumbnail' => {:geometry => "100x75#"}
                    },
                    :convert_options => {
                      :'poster' => '-quality 85',
                      :'thumbnail' => '-quality 85'
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
