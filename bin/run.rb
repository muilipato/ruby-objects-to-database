require 'pry'
require_relative "../config/environment"

def set_database
  Song.create_table
  Song.create name: "99 problems", album: "checkmate"
  Song.create name: "List me down", album: "theres it"
end

set_database

binding.pry
