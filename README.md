# pgvector-racket

[pgvector](https://github.com/pgvector/pgvector) examples for Racket

Supports [db](https://docs.racket-lang.org/db/index.html)

[![Build Status](https://github.com/pgvector/pgvector-racket/actions/workflows/build.yml/badge.svg)](https://github.com/pgvector/pgvector-racket/actions)

## Getting Started

Follow the instructions for your database library:

- [db](#db)

## db

Enable the extension

```racket
(query-exec conn "CREATE EXTENSION IF NOT EXISTS vector")
```

Create a table

```racket
(query-exec conn "CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(3))")
```

Insert vectors

```racket
(query-exec conn "INSERT INTO items (embedding) VALUES ($1::text::vector)" "[1,2,3]")
```

Get the nearest neighbors

```racket
(query-rows conn "SELECT id FROM items ORDER BY embedding <-> $1::text::vector LIMIT 5" "[3,1,2]")
```

Add an approximate index

```racket
(query-exec conn "CREATE INDEX ON items USING hnsw (embedding vector_l2_ops)")
```

Use `vector_ip_ops` for inner product and `vector_cosine_ops` for cosine distance

See a [full example](example.rkt)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/pgvector/pgvector-racket/issues)
- Fix bugs and [submit pull requests](https://github.com/pgvector/pgvector-racket/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/pgvector/pgvector-racket.git
cd pgvector-racket
createdb pgvector_racket_test
raco pkg install db-lib
racket example.rkt
```
