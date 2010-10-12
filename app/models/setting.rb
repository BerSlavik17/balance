class Setting < ActiveRecord::Base
  validates :key, :uniqueness => true, :presence => true

  validates :value, :presence => true

  def self.get key
    Setting.where(:key => key).first.try(:value)
  end

  def self.at_begin
    self.get('at_begin').to_f
  end
end

__END__
  def self.set key, value
    if setting = Setting.get(key)
      setting.update_attributes :key => key, :value => value

      setting
    else
      Setting.create :key => key, :value => value
    end
  end
end
