
[![Docker Automated Badge](https://img.shields.io/docker/cloud/automated/iamrgroot/laravel)](https://hub.docker.com/r/iamrgroot/laravel/)
[![Docker Build Badge](https://img.shields.io/docker/cloud/build/iamrgroot/laravel)](https://hub.docker.com/r/iamrgroot/laravel/)
[![Docker Image Size Badge](https://img.shields.io/docker/image-size/iamrgroot/laravel)](https://hub.docker.com/r/iamrgroot/laravel/)
[![Docker Pulls Badge](https://img.shields.io/docker/pulls/iamrgroot/laravel)](https://hub.docker.com/r/iamrgroot/laravel/)

# Docker image for Laravel with NodeJS and more

Build images are available at https://hub.docker.com/repository/docker/iamrgroot/laravel. See tags for versions used.

### Build image

```bash
docker build . -t username/my-repo:tagname
```

### Build options

Use with `--build-arg`

| var          | default |
|--------------|---------|
| PHP_VERSION  | 7.4-fpm |
| NODE_VERSION | 10      |
| IMAGICK      | true    |

### Push to Docker Hub

```bash
docker login
docker push username/my-repo:tagname
```

### Example

Example [docker-compose.yml](docker-compose.yml) and [.env](.env) files are available. 
