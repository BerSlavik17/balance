class Setting < ActiveRecord::Base
  validates :key, 
    :uniqueness => true,
    :presence => true

  validates :value, :presence => true

  def self.get key
    Setting.where(:key => key).first
  end

  def self.set key, value
    if setting = Setting.get(key)
      setting.update_attributes :key => key, :value => value

      setting
    else
      Setting.create :key => key, :value => value
    end
  end

  def self.at_begin
    find_or_create_by_key('at_begin', :value => '0')
  end
end
