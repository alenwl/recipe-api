# Instructions

## Build
```
docker-compose build
```
## Run tests
```
docker-compose run --rm app sh -c "python manage.py test && flake8"
```
## Start API
```
docker-compose up
```
