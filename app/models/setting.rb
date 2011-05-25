class Setting < ActiveRecord::Base
  validates :key, :uniqueness => true, :presence => true

  validates :value, :presence => true

  def self.get key
    Setting.where(:key => key).first.try(:value)
  end

  def self.at_begin
    self.get('at_begin').to_f
  end

  def self.set key, value
    if setting = Setting.find_by_key(key)
      setting.update_attributes :key => key, :value => value

      setting
    else
      Setting.create :key => key, :value => value
    end
  end

  #TODO: уйти от методов ::get и ::set. Вместо них использовать ::at_begin и ::at_begin= соответственно
end
