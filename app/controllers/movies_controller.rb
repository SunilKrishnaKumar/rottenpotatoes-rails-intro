class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @ratings_to_show = params[:ratings]
    # @sort = params[:sort]
    if @ratings_to_show.nil?
      @movies = Movie.all
    else
      @movies = Movie.with_ratings(@ratings_to_show.keys)
    end
    # a = Array.new()
    # @all_ratings.each do |rat|
    #   a.append(rat)
    # # @sort = params[:sort] || session[:sort]
    # # @ratings = params[:ratings]  || session[:ratings] || @all_ratings
    #   if a.length()>1
    #     @movies = Movie.where( { rating: a } ).order(@sort)
    #   else
    #     @movies = Movie.where( { rating: @all_ratings } ).order(@sort)
    #   end
    # session[:sort], session[:ratings] = @sort, @ratings
    
    # if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      # flash.keep
      # redirect_to movies_path sort: @sort, ratings: @ratings
    # end
    # end
  end
    
    
    
    
    
  #   @all_ratings = ['G','PG','PG-13','R']
  #   session[:ratings] = params[:ratings] unless params[:ratings].nil?
  #   session[:order] = params[:order] unless params[:order].nil?

  #   if (params[:ratings].nil? && !session[:ratings].nil?) || (params[:order].nil? && !session[:order].nil?)
  #     redirect_to movies_path("ratings" => session[:ratings], "order" => session[:order])
  #   elsif !params[:ratings].nil? || !params[:order].nil?
  #     if !params[:ratings].nil?
  #       array_ratings = params[:ratings].keys
  #       return @movies = Movie.where(rating: array_ratings).order(session[:order])
  #     else
  #       return @movies = Movie.all.order(session[:order])
  #     end
  #   elsif !session[:ratings].nil? || !session[:order].nil?
  #     redirect_to movies_path("ratings" => session[:ratings], "order" => session[:order])
  #   else
  #     return @movies = Movie.all
  #   end
  # end
  
  #####
  
    # @all_ratings = Movie.all_ratings
    # @sort = params[:sort] || session[:sort]
    # @ratings = params[:ratings]  || session[:ratings] || all_ratings
    # @movies = Movie.where( { rating: @ratings.keys } ).order(@sort)
    # session[:sort], session[:ratings] = @sort, @ratings
    
    # if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
    #   flash.keep
    #   redirect_to movies_path sort: @sort, ratings: @ratings
###########
  #   sort = params[:sort] || session[:sort]
  #   @all_ratings = Movie.all_ratings
  #   @ratings_to_show = params[:ratings] || session[:ratings] || {}
  #   if @ratings_to_show == {}
  #     @ratings_to_show = Hash[@all_ratings.map {|rating| [rating, rating]}]
  #   end
  #   if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
  #     session[:sort] = sort
  #     session[:ratings] = @ratings_to_show
  #     # redirect_to :sort => sort, :ratings => @ratings_to_show and return
  #   end
  #   @movies = Movie.where(@ratings_to_show.keys)
  #   # Rails.logger.info("Here it is:")
  #   # Rails.logger.info(Movie.all) 
  # end

  #   if params[:sort].nil? && params[:ratings].nil? &&
  #       (!session[:sort].nil? || !session[:ratings].nil?)
  #     redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
  #   end

  #   @sort = params[:sort]
  #   @ratings = params[:ratings] 
  #   if @ratings.nil?
  #     ratings = Movie.ratings 
  #   else
  #     ratings = @ratings.keys
  #   end

  #   @all_ratings = Movie.ratings.inject(Hash.new) do |all_ratings, rating|
  #         all_ratings[rating] = @ratings.nil? ? false : @ratings.has_key?(rating) 
  #         all_ratings
  #     end
      
  #   if !@sort.nil?
  #     begin
  #       @movies = Movie.order("#{@sort} ASC").where(ratings)
  #     rescue ActiveRecord::StatementInvalid
  #       flash[:warning] = "Movies cannot be sorted by #{@sort}."
  #       @movies = Movie.where(ratings)
  #     end
  #   else
  #     @movies = Movie.where(ratings)
  #   end

  #   session[:sort] = @sort
  #   session[:ratings] = @ratings
  # end
    


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
