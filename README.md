# goose-docker
Build and Publish goose images into docker registry.
**** If you don't have any custom changes on goose binary and simply want the goose docker image consider skipping to the [this section](#How-to-use-this-image)
# how to build this goose container
```bash
  $ make all
```

# How to use this image
If you don't want to publish your custom goose image, you can consider picking up the goose docker image from here
[niksw7/goose-alpine](https://hub.docker.com/r/niksw7/goose-alpine/)

The sample docker file for running your migrations will look like this
```yaml  
  FROM niksw7/goose-alpine:v2.3.0
  ENV DB_USER=postgres\
    DB_PASSWORD="*******"\
    DB_HOST=docker.for.mac.localhost\
    DB_PORT=5432\
    DB_NAME=storyboard\
    SCHEMA_NAME=loreans

COPY db/ /db/

CMD [ "sh", "-c", "goose -dir=/db/migrations postgres \"host=$DB_HOST user=$DB_USER password=$DB_PASSWORD dbname=$DB_NAME sslmode=disable search_path=$SCHEMA_NAME\" up"]
```
To build and run the above docker file execute these commands
```bash
docker build -t migration-runner -f Dockerfile .
docker run -it --env DB_USER=anyuser --env DB_PASSWORD=mypassword --env DB_NAME=cosmos migrationrunnerimage
```
