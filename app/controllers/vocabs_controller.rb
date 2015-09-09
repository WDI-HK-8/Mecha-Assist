class VocabsController < ApplicationController

  def index
    @vocabs = Vocab.all
  end

  def create
    @vocab = Vocab.new(vocab_params)
    render json: { message: "400 Bad Request" }, status: :bad_request unless @vocab.save
    render :show
  end

  def update
    @vocab = Vocab.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab" }, status: :not_found
    elsif @vocab.update(vocab_params)
      render :show
    else 
      render json: {message: "Cannot find vocab"}, status: :return_false_no_id
    end
  end
 

  def show
    @vocab = Vocab.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab" }, status: :not_found
    end
  end

  def destroy
    @vocab = Vocab.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab"}, status: :not_found
    elsif @vocab.destroy
      render json: { message: "Successfully deleted" }, status: :no_content
    else
      render json: { message: "Unsuccessfully deleted" }, status: :bad_request
    end
  end

end
