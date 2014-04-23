class Thing < ActiveRecord::Base
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  acts_as_url :name, :sync_url => true, :allow_duplicates => true

  validates_presence_of :filekey, :url

  before_create :generate_url_key

  def file_url?
    filekey.present? && filename.present?
  end

  def file_url
    return nil unless file_url?
    "http://s3.amazonaws.com/#{S3_BUCKET}/things/#{filekey}/#{filename}"
  end

  def name
    length = 50
    return "untitled" unless filename.present?
    return filename.slice(0,length).strip unless body.present?
    body.lines.first.strip.slice(0,length).strip
  end

  def generate_url_key
    begin
      self.url_key = SecureRandom.hex(3)
    end while Thing.exists?(:url_key => url_key)
  end

  def to_param
    "#{url}-#{url_key}"
  end

  class << self
    def from_param(param)
      find_by_url_key!(param.rpartition("-")[2])
    end

    def s3_policy(opts = {})
      Base64.encode64(
        { 
          expiration: 36.hours.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
          conditions: [
            { bucket: S3_BUCKET },
            ['starts-with', '$key', ''],
            ['starts-with', '$Content-Type', ''],
            { acl: 'public-read' }
          ]
        }.to_json
      ).gsub(/\n|\r/, '')
    end

    def s3_signature(opts = {})
      Base64.encode64(
        OpenSSL::HMAC.digest(
          OpenSSL::Digest::Digest.new('sha1'),
          ENV["AWS_SECRET_ACCESS_KEY"],
          s3_policy(secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"])
        )
      ).gsub(/\n/, '')
    end
  end

end
