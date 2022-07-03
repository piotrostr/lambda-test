#!/bin/bash

function_name="func"

aws lambda delete-function \
        --function-name $function_name
