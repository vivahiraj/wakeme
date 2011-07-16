# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wakeme_session',
  :secret      => 'e64de0348f53d8ea8422fa0b8f08dbd985f70615b03fed785dc2194caf0ab0ef7b1445b5ca4307fd50d483d448154c2ab4311ceec907c210ca06e60c8fdf2526'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
