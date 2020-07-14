package main2

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

var db *sql.DB
var err error

type Response struct {
	Er      string `json:"error"`
	Message string `json:"message"`
}

func post(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	var trueapikey string = "Ws58CM6n264Wk318TZwKFnjGucUSN4qZ3qtuzs32kTRqBSP2249hR2sSf8IESfkr"
	r.ParseForm()
	var testapikey string = r.FormValue("apikey")
	var testcategory string = r.FormValue("category")
	//var testpassword string = r.FormValue("password")
	if testcategory == "" || testapikey == "" {
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
	var link string
	var date string
	err := db.QueryRow("select info->>'link' as link,date from news where info->>'category'='$1'", testcategory).Scan(&link, &date)
	switch {
	case err == sql.ErrNoRows:
		respond := Response{
			Er:      "False",
			Message: "Link is " + link + "," + "Date is " + date}
		json.NewEncoder(w).Encode(respond)
		return

	case err != nil:
		respond := Response{
			Er:      "False",
			Message: "Link is " + link + "," + "Date is " + date}
		json.NewEncoder(w).Encode(respond)
		return
	}
	/*if err!=nil {
			for posts.Next(){
			var post Post

			err := posts.Scan(&post.link, &post.date)
			respond := Response{
			Er:      "False",
			Message: "Link is " +post.link+","+"Date is " +post.date
			}
			json.NewEncoder(w).Encode(respond)
			return
		}
	}
	else{
	respond := Response{
		Er:      "True",
		Message: "Invalid Username or Password"}
	json.NewEncoder(w).Encode(respond)
	return
	}*/
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

	r.HandleFunc("/news", post).Methods(http.MethodPost)
	//r.HandleFunc("/register", registration).Methods(http.MethodPost)
	r.HandleFunc("/", notFound)
	log.Fatal(http.ListenAndServe(":8080", r))

}
