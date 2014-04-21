class Thing < ActiveRecord::Base
  belongs_to :project

  def url
    "http://s3.amazonaws.com/#{S3_BUCKET}/things/#{filekey}/#{filename}"
  end

  def to_param
    url
  end

  def as_json(options)
    super({ methods: :url }.merge(options))
  end

  class << self
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
