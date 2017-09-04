# == Schema Information
#
# Table name: newsletters
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Newsletter < ActiveRecord::Base

  #######################
  ## VALIDATIONS

  validates :email, presence: :true, uniqueness: true
  validates :email, format: { with: /\A(\S+)@(.+)\.(\S+)\z/ }

  #######################
  ## SCOPES
  scope :sorted, -> { order(updated_at: :desc, email: :asc) }

  def self.to_csv
    csv_data = CSV.generate(col_sep: ',', force_quotes: true) do |csv|
      # add header
      csv << ["email", "date"]

      # data
      sorted.each do |row|
        csv << [row.email, row.updated_at]
      end
    end

    return csv_data
  end

end
