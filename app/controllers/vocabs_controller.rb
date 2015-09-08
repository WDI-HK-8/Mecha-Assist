class VocabsController < ApplicationController

  def index
    @vocabs = Vocab.all
  end

  def create

    @vocab = Vocab.new(vocab_params)

    if @vocab.save
      #render success in Jbuilder
    else
      render json: { message: "400 Bad Request" }, status: :bad_request
    end

  end

  def update
    @vocab = Vocab.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab" }, status: :not_found
    else
      @vocab.update(vocab_params)
    end
  end

  def show
    @vocab = Vocab.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find your vocab" }, status: :not_found
    end
  end

  def destroy
    @vocab = Vocab.find_by_id(params[:id])

    if @vocab.nil?
      render json: { message: "Cannot find your vocab"}, status: :not_found
    else

      if @vocab.destroy
        render json: { message: "Successfully deleted" }, status: :no_content
      else
        render json: { message: "Unsuccessfully deleted" }, status: :bad_request
      end
    end
  end

end