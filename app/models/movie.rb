class Movie < ActiveRecord::Base
  def self.all_ratings
    ['PG', 'R', 'U', '17', 'PG-12', 'PG-13', 'G']
  end
end
