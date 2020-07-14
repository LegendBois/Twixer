package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"golang.org/x/crypto/bcrypt"
)

var db *sql.DB
var err error

func registration(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	resp := Response{
		Error:   false,
		Message: "",
		UserKey: DefaultUserKey}

	r.ParseForm()
	var testapikey string = r.FormValue("apikey")
	var testusername string = r.FormValue("email")
	var testpassword string = r.FormValue("password")
	if testusername == "" || testpassword == "" || testapikey == "" {
		w.WriteHeader(http.StatusBadRequest)
		resp.sendError("Please Fill all the fields")
		json.NewEncoder(w).Encode(resp)
		return
	}

	if testapikey != TrueAPIKey {
		w.WriteHeader(http.StatusBadRequest)
		resp.sendError("Invalid API key ._.")
		json.NewEncoder(w).Encode(resp)
		return
	}
	// If all Succeed -- DB ops
	var user string

	err := db.QueryRow("SELECT email FROM users WHERE email=$1", testusername).Scan(&user)
	fmt.Println(user, err)
	switch {
	case err == sql.ErrNoRows:
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(testpassword), bcrypt.DefaultCost)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			resp.sendError("User cannot be Created.")
			json.NewEncoder(w).Encode(resp)
			return
		}
		userKey := generatePassword()
		_, err = db.Exec("INSERT INTO users values($1,$2,$3)", testusername, hashedPassword, userKey)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			resp.sendError("User cannot be Created.")
			json.NewEncoder(w).Encode(resp)
			return
		}
		w.WriteHeader(http.StatusCreated)
		resp.Message = "User Created Successfully!"
		resp.UserKey = userKey
		break

	case err == nil:
		w.WriteHeader(http.StatusConflict)
		resp.sendError("User Already Exists!")
		break
	default:
		w.WriteHeader(http.StatusInternalServerError)
		resp.sendError("Server error")
		break
	}
	json.NewEncoder(w).Encode(resp)
	return
}

func post(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	r.ParseForm()

	resp := Response{
		Error:   false,
		Message: "",
		UserKey: DefaultUserKey}

	var testapikey string = r.FormValue("apikey")
	var testusername string = r.FormValue("email")
	var testpassword string = r.FormValue("password")
	if testusername == "" || testpassword == "" || testapikey == "" {
		w.WriteHeader(http.StatusBadRequest)
		resp.sendError("Please Fill all the fields")
		json.NewEncoder(w).Encode(resp)
		return
	}

	if testapikey != TrueAPIKey {
		w.WriteHeader(http.StatusBadRequest)
		resp.sendError("Invalid API key ._.")
		json.NewEncoder(w).Encode(resp)
		return
	}
	// If all Succeed -- DB ops
	var databaseUsername string
	var databasePassword string
	var databaseUserKey string

	err := db.QueryRow("SELECT email, password, current_key FROM users WHERE email=$1", testusername).Scan(&databaseUsername, &databasePassword, &databaseUserKey)

	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		resp.sendError("Invalid Username or Password")
		json.NewEncoder(w).Encode(resp)
		return
	}

	err = bcrypt.CompareHashAndPassword([]byte(databasePassword), []byte(testpassword))

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		resp.sendError("Invalid Username or Password")
		json.NewEncoder(w).Encode(resp)
		return
	}
	w.WriteHeader(http.StatusOK)
	resp.Message = "Login Success! Welcome " + testusername
	resp.UserKey = databaseUserKey
	json.NewEncoder(w).Encode(resp)
	return
}

func notFound(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusNotFound)
	json.NewEncoder(w).Encode(createErrorResponse("Invalid API call! :("))
}

func main() {
	db, err = NewDB("user=apitest password=123456 dbname=twixer sslmode=disable")
	if err != nil {
		panic(err.Error())
	}
	defer db.Close()

	r := mux.NewRouter()

	r.HandleFunc("/login", post).Methods(http.MethodPost)
	r.HandleFunc("/register", registration).Methods(http.MethodPost)
	r.HandleFunc("/", notFound)
	log.Fatal(http.ListenAndServe(":8081", r))

}
