require "brir/version"
require "brir/brir_api"

module Brir
  def self.new(exercise_year = nil)
    BrirApi.new exercise_year
  end
end
