class BookmarksController < ApplicationController
  # before_action :set_bookmark, only: :destroy
  # before_action :set_list, only: [:new, :create]

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    # @bookmark = Bookmark.new(bookmark_params)
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @review = Review.new
      # redirect_to list_path(@list), status: :unprocessable_entity
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  # def set_bookmark
  #   @bookmark = Bookmark.find(params[:id])
  # end

  # def set_list
  #   @list = List.find(params[:list_id])
  # end
end
