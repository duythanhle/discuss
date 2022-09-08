# Disscuss

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Start app with local environment `GITHUB_CLIENT_SECRET=$CLIENT_SECRET GITHUB_CLIENT_ID=$CLIENT_ID mix phx.server`

To start PostgreSQL server:
  ```
  brew install postgresql
  brew services start postgresql
  initdb [YOUR_LOCATION]
  ```


Now you can visit [`localhost:4000`](http://localhost:4000) or [`127.0.0.1:4001`](https://127.0.0.1:4001) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Some useful phx command
  ```
  mix phx.gen.schema Topic topics title:string
  mix phx.gen.schema User users email:string provider:string token:string
  mix phx.gen.socket User
```

## Heroku deploy
  ```
  brew tap heroku/brew && brew install heroku
  heroku create --buildpack hashnuke/elixir
  heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
  heroku addons:create heroku-postgresql:hobby-dev
  git init
  git add .
  git commit -m "Initial commit"
  heroku config:set POOL_SIZE=18
  heroku config:set SECRET_KEY_BASE=
  git push heroku master
  ```
  
## Gigalixir deploy
  ```
  brew tap gigalixir/brew && brew install gigalixir
  gigalixir signup
  gigalixir login
  gigalixir create
  echo "elixir_version=1.12.2" > elixir_buildpack.config
  echo "erlang_version=24.0.3" >> elixir_buildpack.config
  echo "node_version=12.18.1" > phoenix_static_buildpack.config
  git commit -am 'Set up gigalixir buildpacks'
  gigalixir pg:create --free
  git push gigalixir
  gigalixir run mix ecto.migrate
  ```
