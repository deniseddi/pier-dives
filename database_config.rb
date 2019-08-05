require 'active_record' # different speling then on gem

options = {
    adapter:'postgresql',
    database: 'pier_dives'
}
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
