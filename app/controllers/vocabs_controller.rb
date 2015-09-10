class VocabsController < ApplicationController
  before_action :authenticate_user!

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
      render json: { message: "Successfully deleted" }, status: :no_content
    else
      render json: { message: "Unsuccessfully deleted" }, status: :bad_request
    end
  end

  private

  def vocab_params
    params.require(:vocab).permit(:chinese, :english, :pinyin)
  end
end
