package main

import (
	"context"
	"testing"
)

func TestHandler(t *testing.T) {
	res, err := Handler(context.Background(), Event{Name: "test"})
	if err != nil {
		t.Error(err)
	}
	if res != `{"name":"test"}` {
		t.Errorf("Expected %s, got %s", `{"name":"test"}`, res)
	}
}
