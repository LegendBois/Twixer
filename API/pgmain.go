package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"

	_ "github.com/lib/pq"
	"github.com/gorilla/mux"
	"golang.org/x/crypto/bcrypt"
)

var db *sql.DB
var err error

type Response struct {
	Er      string `json:"error"`
	Message string `json:"message"`
}

func registration(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	var trueapikey string = "Ws58CM6n264Wk318TZwKFnjGucUSN4qZ3qtuzs32kTRqBSP2249hR2sSf8IESfkr"
	r.ParseForm()
	var testapikey string = r.FormValue("apikey")
	var testusername string = r.FormValue("username")
	var testpassword string = r.FormValue("password")
	if testusername == "" || testpassword == "" || testapikey == "" {
		respond := Response{
			Er:      "True",
			Message: "Please Fill all the fields"}
		json.NewEncoder(w).Encode(respond)
		return
	}

	if testapikey != trueapikey {
		respond := Response{
			Er:      "True",
			Message: "Invalid API key ._."}
		json.NewEncoder(w).Encode(respond)
		return
	}
	// If all Succeed -- DB ops
	var user string

	err := db.QueryRow("SELECT username FROM users WHERE username=$1", testusername).Scan(&user)
	switch{
	case err == sql.ErrNoRows:
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(testpassword), bcrypt.DefaultCost)
		if err != nil {
			respond := Response{
				Er:      "True",
				Message: "Invalid Username or Password"}
			json.NewEncoder(w).Encode(respond)
			return
		}

		_, err = db.Exec("INSERT INTO users values($1,$2)", testusername, hashedPassword)
		if err != nil {
			respond := Response{
				Er:      "True",
				Message: "User cannot be Created."}
			json.NewEncoder(w).Encode(respond)
			return
		}

		respond := Response{
			Er:      "False",
			Message: "User Created Successfully!"}
		json.NewEncoder(w).Encode(respond)
		return
		
	case err!=nil:
		respond := Response{
				Er:      "True",
				Message: "User Already Exists!"}
			json.NewEncoder(w).Encode(respond)
			return
	}
}

func post(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	var trueapikey string = "Ws58CM6n264Wk318TZwKFnjGucUSN4qZ3qtuzs32kTRqBSP2249hR2sSf8IESfkr"
	r.ParseForm()
	var testapikey string = r.FormValue("apikey")
	var testusername string = r.FormValue("username")
	var testpassword string = r.FormValue("password")
	if testusername == "" || testpassword == "" || testapikey == "" {
		respond := Response{
			Er:      "True",
			Message: "Please Fill all the fields"}
		json.NewEncoder(w).Encode(respond)
		return
	}

	if testapikey != trueapikey {
		respond := Response{
			Er:      "True",
			Message: "Invalid API key ._."}
		json.NewEncoder(w).Encode(respond)
		return
	}
	// If all Succeed -- DB ops
	var databaseUsername string
	var databasePassword string

	err := db.QueryRow("SELECT username, password FROM users WHERE username=$1", testusername).Scan(&databaseUsername, &databasePassword)

	if err != nil {
		respond := Response{
			Er:      "True",
			Message: "Invalid Username or Password"}
		json.NewEncoder(w).Encode(respond)
		return
	}

	err = bcrypt.CompareHashAndPassword([]byte(databasePassword), []byte(testpassword))

	if err != nil {
		respond := Response{
			Er:      "True",
			Message: "Invalid Username or Password"}
		json.NewEncoder(w).Encode(respond)
		return
	}

	respond := Response{
		Er:      "False",
		Message: "Login Success! Welcome " + testusername}
	json.NewEncoder(w).Encode(respond)
	return
}

func notFound(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusNotFound)
	respond := Response{
		Er:      "true",
		Message: "Invalid API call! :("}
	json.NewEncoder(w).Encode(respond)
}

func main() {

	db, err = sql.Open("postgres", "user=postgres password=root dbname=twixer sslmode=disable")
	if err != nil {
		panic(err.Error())
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		panic(err.Error())
	}

	r := mux.NewRouter()

	r.HandleFunc("/login", post).Methods(http.MethodPost)
	r.HandleFunc("/register", registration).Methods(http.MethodPost)
	r.HandleFunc("/", notFound)
	log.Fatal(http.ListenAndServe(":8080", r))

}