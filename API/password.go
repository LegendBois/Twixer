package main

import (
	"log"

	"github.com/sethvargo/go-password/password"
)

func generatePassword() string {
	res, err := password.Generate(64, 10, 0, false, true)
	if err != nil {
		log.Fatal(err)
		return "INVALID"
	}
	//log.Printf(res)
	return res
}
