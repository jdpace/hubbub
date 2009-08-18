# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hubbub_session',
  :secret      => '2270078d527b71a5abcdb2cdfe98b28f9a351da0b48b2c3471634ede8dc6f9db549d4e7692d34d9d0a2af742213a4bdddfa5a93d3a3f747c6fa6b985ff9a4ec9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
