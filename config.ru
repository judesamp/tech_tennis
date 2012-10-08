DATABASE_NAME = "quizzes"
COLLECTION_NAME = [["HTML", "CSS", "Ruby"]["game_data"]["player_data"]]


require './init.rb'


 # ::Views = Module.new #ask Ryan about this and view logic page!!!

map "/" do
	run Implementation::Web
end

map "/api/v1/" do
  run Implementation::API::V1
end

#map "/mobile" do
#  run Implementation::Mobile
#end