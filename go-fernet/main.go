package main

import (
	"time"
	"fmt"
	"github.com/deafbybeheading/fernet-1"
	"os"
)

func main() {
	args := os.Args
	if len(args) != 4 {
		panic("Usage %v [encrypt|decrypt] secret message/token")
	}

	action := args[1]
	switch action {
	case "encrypt": encrypt(args[2], args[3])
	case "decrypt": decrypt(args[2], args[3])
	default: panic(fmt.Sprintf("Invalid action: %v", action))
	}
}

func encrypt(secret, message string) {
	k := fernet.MustDecodeKey(secret)
	token, err := k.EncryptAndSign([]byte(message))
	if err != nil {
		panic(err)
	}
	fmt.Println(string(token))
}

func decrypt(secret, token string) {
	k := fernet.MustDecodeKey(secret)
	g := k.VerifyAndDecrypt([]byte(token), 60*time.Second)
	fmt.Println(string(g))
}
