class Meme < ApplicationRecord

  require "json"
  require "ibm_watson/visual_recognition_v3"
  include IBMWatson

  belongs_to :user

  has_one_attached :meme_img

  has_many :votes, dependent: :destroy
  has_many :meme_taggings, dependent: :destroy
  has_many :tags, through: :meme_taggings
  has_many :voters, through: :votes, source: :user

  validates :title, presence: true
  validates :body, presence: true
  validate :get_explicit_score

  def classify_meme
    path = S3_BUCKET.object(self.meme_img.key).url
    classes = visual_recognition.classify(
      url: path,
      classifier_ids: [:explicit]
    )
    return classes.result
  end

  def get_explicit_score
    result = classify_meme["images"][0]["classifiers"][0]["classes"][0]
    if result["class"] === "explicit"
      errors.add(:img_url, "explicit image")
    end
  end

  def tag_names
    self.tags.map{|tag|
      tag.name
    }.join(', ')
  end

  def tag_names=(rhs)
    self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
      Tag.find_or_initialize_by(name: tag_name)
    end
  end

  private
  def visual_recognition
    visual_recognition = VisualRecognitionV3.new(
      version: "2019-06-27",
      iam_apikey: "aziME45A7BN4w3lJ55C2NAOPApupuwr5-gFdxlKL5eM3"
    )
  end
end
