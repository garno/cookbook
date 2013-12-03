require 'bundler'
Bundler.require

require 'dotenv'
require 'fog'
require 'mini_magick'
Dotenv.load

# Define storage
connection = Fog::Storage.new({
  :provider                 => 'AWS',
  :aws_access_key_id        => ENV['AWS_S3_ACCESS_KEY'],
  :aws_secret_access_key    => ENV['AWS_S3_SECRET_KEY']
})

bucket = connection.directories.create(
  key: ENV['AWS_S3_BUCKET'],
  public: true
)

# Processing picture
image = MiniMagick::Image.open(ARGV[0])
image_output_name = "#{ARGV[1]}.jpg"

image.resize('300x300')
image.write(image_output_name)

bucket.files.create({
  key: "pictures/#{image_output_name}",
  body: File.open(image_output_name),
  public: true
})

bucket.files.create({
  key: "pictures/original_#{image_output_name}",
  body: File.open(ARGV[0]),
  public: true
})

File.delete(image_output_name)
