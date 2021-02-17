class Movie < ActiveRecord::Base
    # attr_accessible :title, :rating, :description, :release_date
    def self.all_ratings
        ['G','PG','PG-13','R']
    end
    
    def self.with_ratings(ratings_list, sort)
        movies = self.where( { rating: ratings_list }).order(sort)
        # end
        return movies
    end
    
end
