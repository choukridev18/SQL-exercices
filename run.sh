#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
DB="$DIR/database.db"
FILE="$DIR/$1"

if [ ! -f "$DB" ]; then
  echo "Base absente. Création via setup.sql..."
  sqlite3 "$DB" < "$DIR/setup.sql"
fi

if [ ! -f "$FILE" ]; then
  echo "Fichier introuvable : $1"
  exit 1
fi

sqlite3 -header -column "$DB" < "$FILE"
