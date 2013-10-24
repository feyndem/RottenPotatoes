class Movie < ActiveRecord::Base
  def self.all_ratings
    ['PG', 'R', 'U', '17', 'PG-12']
  end
end
