class ListsController < ApplicationController

  def index #SEE aALL movie list
    @lists = List.all
  end

  def show #see DETAILS of a movie list
    @list = List.find(params[:id])
  end

  def new #empty form to CREATE
    @list = List.new
  end

  def create #user input in form to CREATE
    @list = List.new(params_list)
    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def params_list #security
    params.require(:list).permit(:name)
  end
end
