#!/bin/bash
DB="/Users/macbook/Desktop/sql/database.db"
FILE="/Users/macbook/Desktop/sql/$1"
sqlite3 -header -column "$DB" < "$FILE"
