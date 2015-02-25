class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki.paginate(page: params[:page], per_page: 10))
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body, :private))
    authorize @wiki
    # adding owner to collaborator list
    # collaborator = @wiki.collaborators.build(user_id: current_user.id)

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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki has been updated."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end

  end

end
