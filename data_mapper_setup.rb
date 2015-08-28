require 'data_mapper'
require 'dm-validations'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://localhost/battleships_#{env}")

require './lib/models/game'
require './lib/models/player'

DataMapper.finalize

DataMapper.auto_upgrade!