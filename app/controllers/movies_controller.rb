class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    
    #initialize sort
    @sort ||= 'id'
    
    # retrieve how to sort from URI route
    @sort = params[:sort_by]
    
    # setup sessions in order to sort them
    # the default sort is by id
    # (the value of sort within session is 'id')
    # session[:sort_by] ||= 'id'
    
    # get the sort variable according to click
    # in index view define session[sort] to be title (if clicked)
    # and session[sort] = date (if clicked) 
    if @sort == "title"
      @title_hilite = "hilite"
    elsif @sort == "release_date"
      @date_hilite = "hilite"
    end
    
    
    # sort them; the list of movies in @movies will be ordered
    # according to the sort variable
    @movies = Movie.order(@sort)
    
    
    
    
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

end
