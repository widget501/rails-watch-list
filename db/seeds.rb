require "open-uri"
require "json"

puts "Cleaning up database..."
List.destroy_all
Movie.destroy_all
Bookmark.destroy_all
Review.destroy_all
puts "Database cleaned"

Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

List.create(name: "Drama")
List.create(name: "Comedy")
List.create(name: "Classic")
List.create(name: "To rewatch")
List.create(name: "Thriller")

Bookmark.create(comment: "BM A great movie", movie_id: 1, list_id: 1)
Bookmark.create(comment: "BM Fantastic!", movie_id: 2, list_id: 2)
Bookmark.create(comment: "BM I enjoyed this movie!", movie_id: 3, list_id: 3)
Bookmark.create(comment: "BM Breathtaking scenes!", movie_id: 4, list_id: 4)
Bookmark.create(comment: "BM Worth a re-watch, anytime", movie_id: 5, list_id: 5)

Review.create(id: 1, comment:"Revw great movie", rating: 5, list_id: 1)
Review.create(id: 2, comment: "Revw Fantastic!", rating: 4, list_id: 2)
Review.create(id: 3, comment: "Revw I enjoyed this movie!", rating: 3, list_id: 3)


url = "http://tmdb.lewagon.com/movie/top_rated"
# 10.times do |i|
1.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)["results"]
  movies.each do |movie|
    puts "Creating #{movie["title"]}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{base_poster_url}#{movie["backdrop_path"]}",
      rating: movie["vote_average"]
    )
  end
end
puts "Movies created"
