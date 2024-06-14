class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]

  def new #representa el formulario vacío
    @bookmark = Bookmark.new
  end

  def create #formulario con info enviada
    @bookmark = Bookmark.new(params_bookmarks)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy!
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def set_list #metpdo para que se aplique esta línea, que debe de ir en el new, create y destroy
    @list = List.find(params[:list_id]) # es list_id por que bookmark está anidada
  end

  def params_bookmarks
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
