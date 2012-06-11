#! /bin/sh
rm ./lib/*.js
coffee -c -o ./lib ./code/src/
rm ./spec/*.js
coffee -c -o ./spec ./code/tests/

