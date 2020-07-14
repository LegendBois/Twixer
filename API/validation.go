package main

import "net/http"

func allParams(r *http.Request) bool {
	if r.FormValue("email") == "" || r.FormValue("password") == "" || r.FormValue("apikey") != TrueAPIKey {
		return false
	}
	return true

}
