# == Schema Information
#
# Table name: external_indicators
#
#  id                :integer          not null, primary key
#  indicator_type    :integer
#  chart_type        :integer
#  scale_type        :integer
#  min               :integer
#  max               :integer
#  show_on_home_page :boolean          default(FALSE)
#  is_public         :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'csv'
class ExternalIndicator < ActiveRecord::Base
  attr_accessor :data_hash

  #######################
  ## TRANSLATIONS

  translates :title, :subtitle, :description, :data, :fallbacks_for_empty_translations => true
  globalize_accessors

  #######################
  ## RELATIONSHIPS
  has_and_belongs_to_many :reforms

  #######################
  ## VALIDATIONS

  validates :indicator_type, :scale_type, :chart_type, presence: :true

  #######################
  ## CONSTANTS
  INDICATOR_TYPES = {basic: 1, country: 2, composite: 3}
  CHART_TYPES = {line: 1, bar: 2}
  SCALE_TYPES = {percent: 1, number: 2}

  #######################
  ## CALLBACKS
  after_initialize :load_data_hash
  before_save :set_data

  # after load, populate data hash
  # format: {
  #   time_periods: [{id, name}]
  #   countries: [{id, name}]
  #   indexes: [{id, name, short_name, change_multiplier}]
  #   data: [{time_period, overall_value, overall_change, values[{index/country, value, change}] }]
  # }
  def load_data_hash
    self.data_hash = self.data.present? ? JSON.parse(self.data, symbolize_names: true) : {}
    return true
  end

  # convert the data hash to json string
  def set_data
    self.data = self.data_hash.to_json if self.data_hash.present?
    return true
  end

  #######################
  ## SCOPES
  scope :published, -> { where(is_public: true) }
  scope :sorted, -> { with_translations.order(title: :asc) }
  scope :for_home_page, -> { where(show_on_home_page: true) }


  # columns:
  # - basic: time, value
  # - country: time, country, value
  # - composite: time, index, value
  # format: {
  #   time_periods: [{id, name}]
  #   countries: [{id, name}]
  #   indexes: [{id, name, short_name, change_multiplier}]
  #   data: [{time_period, overall_value, overall_change, values[{index/country, value, change}] }]
  # }
  def self.to_csv(external_indicator_id=nil)
    ext_ind = published.find_by(id: external_indicator_id)

    case ext_ind.indicator_type
      when INDICATOR_TYPES[:basic]
        header = %w{time_period value}

        CSV.generate do |csv|
          csv << header
          ext_ind.data_hash[:data].each do |data|
            tp = ext_ind.data_hash[:time_periods].select{|x| x[:id] == data[:time_period]}.first
            if tp.present?
              csv << [tp[:name], data[:values][0][:value]]
            end
          end
        end

      when INDICATOR_TYPES[:country]
        header = %w{time_period place value}

        CSV.generate do |csv|
          csv << header
          ext_ind.data_hash[:data].each do |data|
            tp = ext_ind.data_hash[:time_periods].select{|x| x[:id] == data[:time_period]}.first
            if tp.present?
              data[:values].each do |value|
                c = ext_ind.data_hash[:countries].select{|x| x[:id] == value[:country]}.first
                if c.present?
                  csv << [tp[:name], c[:name], value[:value]]
                end
              end
            end
          end
        end

      when INDICATOR_TYPES[:composite]
        header = %w{time_period indicator value}

        CSV.generate do |csv|
          csv << header
          ext_ind.data_hash[:data].each do |data|
            tp = ext_ind.data_hash[:time_periods].select{|x| x[:id] == data[:time_period]}.first
            if tp.present?
              csv << [tp[:name], 'Overall', data[:overall_value]]
              data[:values].each do |value|
                i = ext_ind.data_hash[:indexes].select{|x| x[:id] == value[:index]}.first
                if i.present?
                  csv << [tp[:name], i[:short_name], value[:value]]
                end
              end
            end
          end
        end

    end
  end

  #######################
  ## METHODS

  # format the data for charting
  # - use the chart type and indicator type to create the proper hash format for charting
  # format: chart_type, title, subtitle, min, max, categories[], series[ {name: '', data: [ {y, change} ] } ]
  def format_for_charting
    chart_type = self.chart_type == CHART_TYPES[:line] ? 'area' : 'column'
    hash = {chart_type: chart_type, title: self.title, subtitle: self.subtitle, min: self.min, max: self.max, categories: [], series: []}

    # add x-axis lables (categories)
    hash[:categories] = self.data_hash[:time_periods].map{|x| x[:name]}

    # add data
    # based off of indicator type, build the data accordingly
    case self.indicator_type
      when INDICATOR_TYPES[:basic]
        hash[:series] << {data: self.data_hash[:data].map{|x| {y: x[:values].first[:value], change: x[:values].first[:change]}}}

      when INDICATOR_TYPES[:country]
        self.data_hash[:countries].each do |country|
          item = {name: country[:name], data: []}
          self.data_hash[:data].each do |data|
            # find the data item for this country
            d = data[:values].select{|x| x[:country] == country[:id]}.first
            if d.present?
              item[:data] << {y: d[:value], change: d[:change]}
            else
              item[:data] << {y:nil, change: nil}
            end
          end
          hash[:series] << item
        end

      when INDICATOR_TYPES[:composite]
        self.data_hash[:indexes].each do |index|
          item = {name: index[:name], data: []}
          self.data_hash[:data].each do |data|
            # find the data item for this index
            d = data[:values].select{|x| x[:index] == index[:id]}.first
            if d.present?
              item[:data] << {y: d[:value], change: d[:change]}
            else
              item[:data] << {y:nil, change: nil}
            end
          end
          hash[:series] << item
        end

    end

    return hash

  end


end