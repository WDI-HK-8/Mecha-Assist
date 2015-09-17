# encoding: UTF-8

class VocabsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @vocabs = current_user.vocabs.all
  end

  def create
    if @vocab = current_user.vocabs.create(vocab_params)
      render :show
    else
      render json: { message: "400 Bad Request" }, status: :bad_request
    end
  end

  def update
    @vocab = current_user.vocabs.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab" }, status: :not_found
    elsif @vocab.update(vocab_params)
      render :show
    else
      render json: {message: "Cannot find vocab"}, status: :return_false_no_id
    end
  end


  def show
    @vocab = current_user.vocabs.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab" }, status: :not_found
    end
  end

  def destroy
    @vocab = current_user.vocabs.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab"}, status: :not_found
    elsif @vocab.destroy
      render json: { message: "Successfully deleted" }
    else
      render json: { message: "Unsuccessfully deleted" }, status: :bad_request
    end
  end

  def translate
    traditional_chinese = params[:chinese]

    # 1. get simplified version of chinese
    require 'tradsim'
    simplified_chinese = Tradsim::to_sim(traditional_chinese)

    # 2. segmenter ==> break into chinese words
    sina_response = Curl.get("http://5.tbip.sinaapp.com/api.php?type=json&str=#{simplified_chinese}")
    simplified_vocabs = sina_response.body

    # 3. add english translation and pinyin
    require 'ruby-pinyin'
    @vocabs = []
    reject_characters = [',', '。', '（',  '）',  '？', '』', '」', '，', '「', '『', '、', '~']
    JSON.parse(simplified_vocabs).each do |vocab|
      @vocabs << {
        chinese: vocab['word'],
        pinyin:  PinYin.of_string(vocab['word']).join(', '),
        english: translate_google(vocab['word'])
      } unless reject_characters.include?(vocab['word'])
    end

    # Translate the whole text
    translation = translate_google(traditional_chinese)

    # send to frontend
    render json: {
      vocabs: @vocabs.to_json,
      translation: translation
    }
  end

  private

  def vocab_params
    params.require(:vocab).permit(:chinese, :english, :pinyin)
  end

  def translate_google(simplified)
    apikey = 'AIzaSyDvXV4bN47jVG5_jd4bs_Z9RVGLrY9yr3g';
    result = Curl.get("https://www.googleapis.com/language/translate/v2?q=#{simplified}&target=en&key=#{apikey}")
    response = JSON.parse(result.body_str)
    return response["data"]["translations"][0]["translatedText"]
  end

end
