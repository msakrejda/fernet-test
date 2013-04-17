#!/bin/bash

FERNET_SECRET="beuVqUxoaR9fNqJ9Fq3yCsUOFTW3l1PmJcDRZJEssco="

ruby_encrypted=$(cd rb-fernet && bundle exec ./fernet.rb encrypt "$FERNET_SECRET" 'hello world')
golang_encrypted=$(cd go-fernet && go get && ./go-fernet encrypt "$FERNET_SECRET" 'hello world')

echo "Ruby -> Ruby:"
(cd rb-fernet && bundle exec ./fernet.rb decrypt "$FERNET_SECRET" "$ruby_encrypted")
echo "Go -> Ruby:"
(cd rb-fernet && bundle exec ./fernet.rb decrypt "$FERNET_SECRET" "$golang_encrypted")
echo "Go -> Go:"
(cd go-fernet && go get && ./go-fernet decrypt "$FERNET_SECRET" "$golang_encrypted")
echo "Ruby -> Go:"
(cd go-fernet && go get && ./go-fernet decrypt "$FERNET_SECRET" "$ruby_encrypted")
