package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

var err error

func (env *Env) registration(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	resp := Response{
		Error:   false,
		Message: "",
		UserKey: DefaultUserKey}

	r.ParseForm()

	if !allParams(r) {
		w.WriteHeader(http.StatusBadRequest)
		resp.sendError("Invalid API request")
	} else {

		// If all Succeed -- DB ops

		statusCode, err := checkRegistration(env.db, r.FormValue("email"), r.FormValue("password"), &resp)
		w.WriteHeader(statusCode)
		if err != nil {
			log.Println("Registration Error: " + r.FormValue("email") + " " + err.Error())
		} else {
			log.Println("Registration successful: " + r.FormValue("email"))
		}
	}
	json.NewEncoder(w).Encode(resp)
	return
}

func (env *Env) login(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	r.ParseForm()

	resp := Response{
		Error:   false,
		Message: "",
		UserKey: DefaultUserKey}

	if !allParams(r) {
		w.WriteHeader(http.StatusBadRequest)
		resp.sendError("Invalid API request")
	} else {
		// If all Succeed -- DB ops
		statusCode, err := checkLogin(env.db, r.FormValue("email"), r.FormValue("password"), &resp)
		w.WriteHeader(statusCode)
		if err != nil {
			log.Println("Invalid login: " + r.FormValue("email") + " " + err.Error())
		} else {
			log.Println("Login successful: " + r.FormValue("email"))
		}
	}
	json.NewEncoder(w).Encode(resp)
	return
}

func notFound(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusNotFound)
	json.NewEncoder(w).Encode(createErrorResponse("Invalid API call! :("))
}

func main() {
	db, err := NewDB("user=apitest password=123456 dbname=twixer sslmode=disable")
	if err != nil {
		panic(err.Error())
	}
	defer db.Close()

	env := &Env{db: db}

	r := mux.NewRouter()

	r.HandleFunc("/login", env.login).Methods(http.MethodPost)
	r.HandleFunc("/register", env.registration).Methods(http.MethodPost)
	r.HandleFunc("/", notFound)
	log.Fatal(http.ListenAndServe(":8081", r))

}
