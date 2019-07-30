class Meme < ApplicationRecord

  require "json"
  require "ibm_watson/visual_recognition_v3"
  include IBMWatson

  belongs_to :user

  before_create :get_explicit_score
  
  validates :img_url, presence: true
  validates :title, presence: true
  validates :body, presence: true

  def classify_meme(url)
    classes = visual_recognition.classify(
      url: url,
      classifier_ids: [:explicit]
    )
    p classes.result
    return classes.result
  end

  def get_explicit_score
    result = classify_meme(self.img_url)["images"][0]["classifiers"][0]["classes"]

    if result["class"] == "explicit"
      errors.add(:img_url, "explicit image")
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
