#!/usr/bin/env ruby

require 'fernet'
require 'json'

# Ensure we see logs
$stdout.sync = true
def decrypt(secret, token)
  verifier = Fernet.verifier(secret, token)
  if verifier.valid?
    puts verifier.data
  end
end

def encrypt(secret, message)
  token = Fernet.generate(secret) do |generator|
    generator.data = 'hello world'
  end
  puts token
end

if ARGV.count != 3
  raise StandardError, "Usage %v [encrypt|decrypt] secret message/token"
end

action = ARGV[0]

case action
when 'encrypt'
  encrypt(ARGV[1], ARGV[2])
when 'decrypt'
  decrypt(ARGV[1], ARGV[2])
end
