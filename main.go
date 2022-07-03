package main

import (
	"context"
	"encoding/json"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	Name string `json:"name"`
}

func Handler(ctx context.Context, name Event) (string, error) {
	res, err := json.Marshal(name)
	if err != nil {
		return "", err
	}
	return string(res), nil
}

func main() {
	lambda.Start(Handler)
}
