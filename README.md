# AWS lambda function test

The `main.go` handler is a sample Go handler, `/deploy.sh` is a cool idempotent
script that can be re-run and it checks for the resources required and creates
them if not there.

Clean up using `/delete.sh`, the roles are not deleted though, since there are
no extra charges for the roles (AWS IAM is free).

I might write a comparative review after completing a similar workflow on GCP.
