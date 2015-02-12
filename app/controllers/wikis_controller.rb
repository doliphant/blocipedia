class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    if @wiki.save
      flash[:notice] = "Wiki has been saved."
      redirect_to @wiki
    else
      flash[:notice] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki has been updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    # authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end

  end

end
