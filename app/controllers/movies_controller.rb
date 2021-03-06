class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # session.clear
    # debugger
    if not params[:home]
      session.clear
    end
    # if (params.has_key?(:sort) || params.has_key?(:ratings) || !params.has_key?(:commit))
    #   session[:home] = 1
    # end
    
    if(params[:sort].nil? && params[:ratings].nil? && !params.has_key?(:commit) && params[:home])
      if(!session[:sort].nil? || !session[:ratings].nil?)
        redirect_to movies_path(:sort=>session[:sort], :ratings=>session[:ratings], :home => true)
        # [:sort, :ratings].each { |k| session.delete(k) }
      end
    end
    @sort = params[:sort]
    @all_ratings = Movie.all_ratings
    # debugger
    # @ratings_to_show = @all_ratings
    
    if params[:ratings].nil?
      @ratings_to_show = @all_ratings
      @movies = Movie.with_ratings(@ratings_to_show, @sort)
    else
      # debugger
      if params[:ratings].is_a? Array
        @ratings_to_show = params[:ratings]
      else
        @ratings_to_show = params[:ratings].keys
      end
      @movies = Movie.with_ratings(@ratings_to_show, @sort)
      session[:ratings] = params[:ratings]
    end
    session[:sort] = @sort
    session[:home] = false
  end
    
    
    
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  # def chosen_rating?(rating)
  #   chosen_ratings = session[:ratings]
  #   return true if chosen_ratings.nil?
  #   chosen_ratings.include? rating
  # end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  
end
