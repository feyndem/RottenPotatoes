class MoviesController < ApplicationController
  def index
    @all_ratings = @keys = Movie.all_ratings
    if (params.has_key?(:criteria) && params.has_key?(:ratings))
      @keys = params[:ratings].keys 
      @movies = @movies = Movie.where(rating: @keys).order(params[:criteria])
    elsif (params.empty? && ! session.has_key?(:criteria) && ! session.has_key?(:ratings))
      @movies = Movie.all
    else
      params[:criteria] = session[:criteria] unless params.has_key?(:criteria)
      params[:ratings] = session[:ratings] unless params.has_key?(:ratings)
      session[:criteria] = params[:criteria]
      session[:ratings] = params[:ratings]
      redirect_to movies_path(:criteria => params[:criteria], :ratings => params[:ratings])
    end 
    @order = params[:criteria]
    
#    if (params.has_key?(:ratings))
#      @keys = params[:ratings].keys
#      session[:ratings] = params[:ratings]
#      if (session.has_key?(:criteria))
#        params[:criteria] = session[:criteria]
#        @movies = Movie.where(rating: @keys).order(session[:criteria])
#      else
#        @movies = Movie.where(rating: @keys)
#      end
#    end
#    
#    if (params.has_key?("criteria"))
#      criteria = params[:criteria]
#      session[:criteria] = params[:criteria]
#      if (session.has_key?(:ratings))
#        @keys = session[:ratings].keys
#        @movies = Movie.where(rating: @keys).order(session[:criteria])
#      else
#        @movies = Movie.order(criteria)
#      end
#      @order = criteria    
#    end  
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
