class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    while true
      shorty_url = SecureRandom.urlsafe_base64
      return shorty_url unless ShortenedUrl.exists?(short_url: shorty_url)
    end
  end

  def self.make(user, longy_url) #<-- ask about this
    shorty_url = ShortenedUrl.random_code

    ShortenedUrl.create!(short_url: shorty_url, long_url: longy_url, user_id: user.id)
  end

  def num_clicks
    visits.length
  end

  def num_uniques
    visits.select(:user_id).distinct.length
  end

  def num_recent_uniques
    visits
      .select(:user_id)
        .distinct
          .where("created_at >= ?", 50.hours.ago).length
  end
end
