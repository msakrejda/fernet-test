#!/bin/bash

fernet_secret="beuVqUxoaR9fNqJ9Fq3yCsUOFTW3l1PmJcDRZJEssco="
message="hello world"

ruby_encrypted=$(cd rb-fernet && bundle exec ./fernet.rb encrypt "$fernet_secret" "$message")
golang_encrypted=$(cd go-fernet && go get && ./go-fernet encrypt "$fernet_secret" "$message")

echo "Ruby -> Ruby:"
(cd rb-fernet && bundle exec ./fernet.rb decrypt "$fernet_secret" "$ruby_encrypted")
echo "Go -> Ruby:"
(cd rb-fernet && bundle exec ./fernet.rb decrypt "$fernet_secret" "$golang_encrypted")
echo "Go -> Go:"
(cd go-fernet && go get && ./go-fernet decrypt "$fernet_secret" "$golang_encrypted")
echo "Ruby -> Go:"
(cd go-fernet && go get && ./go-fernet decrypt "$fernet_secret" "$ruby_encrypted")
