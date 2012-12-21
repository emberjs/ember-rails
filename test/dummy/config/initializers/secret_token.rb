# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Dummy::Application.config.secret_token = '3499a0cb5ffbbcbf4a36f0202d145eac76a1e58ed992b7f7deb659d776b25c658799dbd3b69ecd913ad645e8e694673ae41393d4e6353ae86105f3fc099d7d66'

# Renamed in rails 4
Dummy::Application.config.secret_key_base = Dummy::Application.config.secret_token