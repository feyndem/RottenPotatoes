class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.all_ratings
    @movies = Movie.all
    
    if (params.has_key?(:ratings))
      keys = params[:ratings].keys
      @movies = Movie.where(rating: keys)      
    end
    
    if (params.has_key?("criteria"))
      criteria = params[:criteria]
      @movies = Movie.order(criteria)
      @order = criteria     
    end
    
  end
  
  def show
    id = params[:id]
    @movie = Movie.find(id)
  end
  
  def new
    
  end
  
  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was succesfully created!"
    redirect_to movies_path
  end
  
  def edit
    @movie = Movie.find params[:id]
  end
  
  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was succesfully deleted!"
    redirect_to movies_path
  end
  
  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was succesfully updated!"
    redirect_to movie_path(@movie)    
  end
end
