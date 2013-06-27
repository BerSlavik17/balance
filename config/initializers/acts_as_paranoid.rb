require 'active_support/concern'

module ActsAsParanoid
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(deleted_at: nil) }
  end

  def destroy
    touch :deleted_at
  end

  def paranoid?
    true
  end

  module ClassMethods
    def paranoid?
      true
    end
  end
end

class ActiveRecord::Base
  def self.acts_as_paranoid
    include ActsAsParanoid
  end

  def self.paranoid?
    false
  end
end
