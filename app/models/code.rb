class Code < ActiveRecord::Base
  belongs_to :product

  validates :value,:uniqueness => true
  scope :used, where("used_at is not null")
  scope :not_used, where("used_at is null")


  class << self
  def authorize_code(code)
    where("value = ? and used_at is not null", code).first
  end

  end

  def auth!
    update_attribute :used_at, Time.now
  end

end
