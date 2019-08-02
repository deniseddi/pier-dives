require 'active_record' # different speling then on gem
require 'pry'

options = {
    adapter:'postgresql',
    database: 'pier_dives'
}
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
