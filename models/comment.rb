class Comment < ActiveRecord::Base
    belongs_to :user #describing the relationship comments belongs to one user
end