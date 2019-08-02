# dives = ["one","two","three","four","five","six"]

# 6.times do 
#     dive = Dive.New
#     dive.title = "#{dives.sort}"
#     dive.save
# end

<% @comments.each do |comment|
    <p><%= comment.body %><%= comment.pier_id%><p>

    <p><%= comment.body %> by <%= User.find(comment.user_id).email %></p> 