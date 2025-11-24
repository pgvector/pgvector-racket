#lang racket

(require db)

(define conn (postgresql-connect #:user (getenv "USER") #:database "pgvector_racket_test"))

(query-exec conn "CREATE EXTENSION IF NOT EXISTS vector")

(query-exec conn "DROP TABLE IF EXISTS items")

(query-exec conn "CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(3))")

(query-exec conn "INSERT INTO items (embedding) VALUES ($1::text::vector), ($2::text::vector)" "[1,2,3]" "[4,5,6]")

(query-rows conn "SELECT id FROM items ORDER BY embedding <-> $1::text::vector LIMIT 5" "[3,1,2]")
