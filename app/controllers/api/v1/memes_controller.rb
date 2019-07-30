class Api::V1::MemesController < Api::ApplicationController

  require "json"
  require "ibm_watson/visual_recognition_v3"
  include IBMWatson

  def index
    visual_recognition = VisualRecognitionV3.new(
      version: "2019-06-27",
      iam_apikey: "aziME45A7BN4w3lJ55C2NAOPApupuwr5-gFdxlKL5eM3"
    )
    
    File.open("app/assets/images/porn.jpeg") do |image_file|
      classes = visual_recognition.classify(
        images_file: image_file,
        threshold: "0.4",
        classifier_ids: ["explicit"]
      )
      puts JSON.pretty_generate(classes.result)
    end
    
    memes = Meme.all

    render(json: memes)
  end
  private

  visual_recognition = VisualRecognitionV3.new(
    version: "2019-06-27",
    iam_apikey: "aziME45A7BN4w3lJ55C2NAOPApupuwr5-gFdxlKL5eM3"
  )
end
