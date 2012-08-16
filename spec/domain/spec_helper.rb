require 'spec'
require 'rack/test'

#load all your stuff either explicitly:
require '../../../domain/entities/game'

# this MIGHT work for the whole deal
# Dir.glob(File.expand_path("./domain") +"/**/*.rb").each do |file|
#   require file
# end