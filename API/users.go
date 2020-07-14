package main

import (
	"database/sql"
	"errors"
	"net/http"

	"golang.org/x/crypto/bcrypt"
)

func checkRegistration(db *sql.DB, username string, password string, resp *Response) (int, error) {

	var user string
	var statusCode int
	var errRet error = nil

	err := db.QueryRow("SELECT email FROM users WHERE email=$1", username).Scan(&user)
	switch {
	case err == sql.ErrNoRows:
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
		if err != nil {
			resp.sendError("User cannot be Created.")
			return http.StatusInternalServerError, err
		}
		userKey := generatePassword()
		_, err = db.Exec("INSERT INTO users values($1,$2,$3)", username, hashedPassword, userKey)
		if err != nil {
			resp.sendError("User cannot be Created.")
			return http.StatusInternalServerError, err
		}
		statusCode = http.StatusCreated
		resp.Message = "User Created Successfully!"
		resp.UserKey = userKey
		break

	case err == nil:
		statusCode = http.StatusConflict
		errRet = errors.New("User exists")
		resp.sendError("User Already Exists!")
		break
	default:
		statusCode = http.StatusInternalServerError
		resp.sendError("Server error")
		errRet = err
		break
	}
	return statusCode, errRet
}

func checkLogin(db *sql.DB, username string, password string, resp *Response) (int, error) {

	var databaseUsername string
	var databasePassword string
	var databaseUserKey string

	err := db.QueryRow("SELECT email, password, current_key FROM users WHERE email=$1", username).Scan(&databaseUsername, &databasePassword, &databaseUserKey)

	if err != nil {
		resp.sendError("Invalid Username or Password")
		return http.StatusUnauthorized, err
	}

	err = bcrypt.CompareHashAndPassword([]byte(databasePassword), []byte(password))

	if err != nil {
		resp.sendError("Invalid Username or Password")
		return http.StatusUnauthorized, err
	}

	resp.Message = "Login Success! Welcome " + username
	resp.UserKey = databaseUserKey
	return http.StatusOK, nil
}
