class MoviesController < ApplicationController
  def index
    @all_ratings = @keys = Movie.all_ratings
    if params.has_key?(:commit) && !params.has_key?(:ratings)
      params[:ratings] = session[:ratings]
    end
    
    if (!params.has_key?(:criteria) && session.has_key?(:criteria))
      flash.keep
      redirect_to movies_path(params.merge({:criteria => session[:criteria]}))
    end
    if (!params.has_key?(:ratings) && session.has_key?(:ratings))
      flash.keep
      redirect_to movies_path(params.merge({:ratings => session[:ratings]}))
    end

    if params.has_key?(:criteria) && params.has_key?(:ratings)
      @keys = params[:ratings].keys
      @movies = Movie.where(rating: @keys).order(params[:criteria])
      session[:criteria] = params[:criteria]
      session[:ratings] = params[:ratings]
    elsif params.has_key?(:criteria)
      @movies = Movie.order(params[:criteria])
      session[:criteria] = params[:criteria]
    elsif params.has_key?(:ratings)
      session[:ratings] = params[:ratings]      
      @keys = params[:ratings].keys
      @movies = Movie.where(rating: @keys)
    else
      @movies = Movie.all
    end
    @order = params[:criteria]
    
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
