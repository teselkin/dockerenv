#!/bin/bash
base64 parser.sh > parser.b64
{
  echo 'RUN echo \'
  while read line; do
    echo "${line}\\"
  done < parser.b64
  echo '| base64 -d | ID=${idstring} bash'
} > setup-user
rm parser.b64
