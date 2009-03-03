# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_comatoast_session',
  :secret      => '56f5aa0a3cf021a6034deb83afd3c5ebd226296e798a7c774442e23fe6c99c6584f32504b3890898706e6fdaad19f077b1a61ec0d487e2953e4518ea363c0ec8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
