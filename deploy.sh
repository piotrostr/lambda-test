#!/bin/bash


function_name="func"

printf "Checking if the lambda role exists\n"
if ! aws iam get-role --role-name lambda-role > /dev/null; then
        printf "Nope, creating lambda role\n"
        aws iam create-role \
                --role-name lambda-role \
                --assume-role-policy-document file://trust-policy.json
else
        printf "Yup\n"
fi

printf "Attaching lambda policy\n"
aws iam attach-role-policy \
        --role-name lambda-role \
        --policy-arn \
        arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

printf "Building and packing\n"
GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build -o main main.go
zip func.zip main

if aws lambda get-function --function-name $function_name > /dev/null; then
        printf "Function exists, updating\n"
        aws lambda update-function-code \
                --function-name $function_name \
                --zip-file fileb://func.zip
else
        printf "Function does not exist, creating\n"
        aws lambda create-function \
                --function-name $function_name \
                --runtime go1.x \
                --handler main \
                --zip-file fileb://func.zip \
                --role $(aws iam get-role --role-name lambda-role | jq .Role.Arn -r) \
                | jq
fi
