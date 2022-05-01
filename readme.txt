docker-compose run rails rails new . --force --no-deps --database=mysql --css=bootstrap
docker-compose run rails rails db:create
docker-compose up

docker-compose exec rails bash
bin/rails g scaffold blog  title:string content:text
bin/rails db:migrate