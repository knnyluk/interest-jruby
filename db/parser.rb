require 'JSON'
require 'pry'


seed_file = File.read('kelseyfacebookdata.json')#('ken_fbfriends_likes.json')
json = JSON.parse(seed_file)

friends = json['friends']['data']
# p friends
user_movies = {}
friends.each do |friend|
  # binding.pry
  # unless friend['likes'].nil? && friend['likes']['data'].select { |interest| interest['category'] == 'Movie'}.nil?
  #   user_movies[friend['id']] = friend['likes']['data'].select { |interest| interest['category'] == 'Movie'}
  # end
  if friend['likes'] && friend['likes']['data'].select { |interest| interest['category'] == 'Movie'} != []
    user_movies[friend['id']] = friend['likes']['data'].select { |interest| interest['category'] == 'Movie'}
  end
end

p user_movies
binding.pry
p


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'JSON'

# require 'pry'


seed_file = File.read('db/cam.json')#('ken_fbfriends_likes.json')
json = JSON.parse(seed_file)

friends = json['friends']['data']
# p friends
user_movies = {}
friends.each do |friend|
  # binding.pry
  # unless friend['likes'].nil? && friend['likes']['data'].select { |interest| interest['category'] == 'Movie'}.nil?
  #   user_movies[friend['id']] = friend['likes']['data'].select { |interest| interest['category'] == 'Movie'}
  # end
  if friend['likes'] && friend['likes']['data'].select { |interest| interest['category'] == 'Movie'} != []
    user_movies[friend['id']] = friend['likes']['data'].select { |interest| interest['category'] == 'Movie'}
  end
end

user_movies.each do |k,v|
  user = @neo.create_node("user_id" => k)
  @neo.add_label(user, "user")
  v.each do |movie|
    if m = @neo.find_nodes_labeled('movie', {:name => movie["name"]})
    #   m_idx = @neo.get_node_index("movie", "name", movie['name'])
    #   m = get_node(m_idx)
      "whatever"
    else
      m = @neo.create_node('name' => movie['name'])
      @neo.add_label(m, "movie")
    end
      @neo.create_relationship("like", user, m)
  end
end
