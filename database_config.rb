require 'active_record'
require 'pry'

options = {
    adapter:'postgresql',
    database: 'pier_dives'
}
ActiveRecord::Base.establish_connection(options)
