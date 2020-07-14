package main

//Response : JSON response for requests
type Response struct {
	Error   bool   `json:"error"`
	Message string `json:"message"`
	UserKey string `json:"userkey"`
}

func createErrorResponse(err string) Response {
	return Response{
		Error:   true,
		Message: err,
		UserKey: DefaultUserKey}
}

func (r *Response) sendError(err string) {
	r.Error = true
	r.Message = err
}
