#!/bin/bash

token=$BOT_TOKEN
chat_id=$CHAT_ID
parse_mode=$PARSE_MODE
message=$MESSAGE
disable_notification=$DISABLE_NOTIFICATION

if [[ -z $token ]]
then
    echo 'Not passed required BOT_TOKEN environment variable' >&2
    exit 1
fi

if [[ -z $chat_id ]]
then
    echo 'Not passed required CHAT_ID environment variable' >&2
    exit 2
fi

if [[ -z $message ]]
then
    echo 'Not passed required MESSAGE environment variable' >&2
    exit 3
fi

if [[ -z $parse_mode ]]
then
    parse_mode='Markdown'
fi

if [[ -z $disable_notification ]]
then
    disable_notification=false
fi

request="{\"text\":\"${message}\",\"parse_mode\":\"${parse_mode}\",\"chat_id\":${chat_id},\"disable_notification\":${disable_notification}}"

curl -X POST \
     -H "Content-Type: application/json" \
     -d "${request}" \
     "https://api.telegram.org/bot${token}/sendMessage"
