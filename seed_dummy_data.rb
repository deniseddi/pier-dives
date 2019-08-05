

<% @comments.each do |comment|
    <p><%= comment.body %><%= comment.pier_id%><p>

    <p><%= comment.body %> by <%= User.find(comment.user_id).email %></p> 