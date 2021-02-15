class Movie < ActiveRecord::Base
    # attr_accessible :title, :rating, :description, :release_date
    def self.all_ratings
        ['G','PG','PG-13','R']
    end
    
    def self.with_ratings(ratings_list)
        # if ratings_list.empty?
        #     movies = self.where( { rating: self.all_ratings} )
        # else
        movies = self.where( { rating: ratings_list } )
        # end
        return movies
    end
    
end
