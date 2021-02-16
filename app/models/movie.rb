class Movie < ActiveRecord::Base
    # attr_accessible :title, :rating, :description, :release_date
    def self.all_ratings
        ['G','PG','PG-13','R']
    end
    
    def self.with_ratings(ratings_list, sort)
        # if ratings_list.empty?
        #     movies = self.where( { rating: self.all_ratings} )
        # else
        # debugger
        movies = self.where( { rating: ratings_list }).order('%s ASC'[sort.to_s])
        # end
        return movies
    end
    
end
