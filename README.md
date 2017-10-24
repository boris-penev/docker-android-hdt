# Docker Android Build Environment HDT


[![Build Status](https://travis-ci.org/boris-penev/docker-android-hdt.svg?branch=master)](https://travis-ci.org/boris-penev/docker-android-hdt)

[![docker icon](http://dockeri.co/image/borispenev/docker-android-hdt)](https://hub.docker.com/r/borispenev/docker-android-hdt/)


## Introduction

A **docker** image build with **Android** build environment.


## What Is Inside

It includes the following components:

* Ubuntu 17.10
* Android SDK 24
* Android build tools 24.0.2
* extra-android-m2repository
* extra-google-m2repository
* TestNG
* Python 2, Python 3


## Docker Pull Command

The docker image is publicly automated build on [Docker Hub](https://hub.docker.com/r/borispenev/docker-android-hdt/) based on the Dockerfile in this repo, so there is no hidden stuff in it. To pull the latest docker image:

    docker pull borispenev/docker-android-hdt:latest


## Usage

### Use the image to build an Android project

You can use this docker image to build your Android project with a single docker command:

    cd <android project directory>  # change working directory to your project root directory.
    docker run --rm -v `pwd`:/project borispenev/docker-android-hdt bash -c 'cd /project; ./gradlew build'



### Use the image for a Bitbucket pipeline

If you have an Android project in a Bitbucket repository and want to use its pipeline to build it, you can simply specify this docker image.
Here is an example of `bitbucket-pipelines.yml`

    image: borispenev/docker-android-hdt:latest

    pipelines:
      default:
        - step:
            script:
              - chmod +x gradlew
              - ./gradlew assemble

If gradlew is marked as executable in your repository as recommended, remove the `chmod` command.


## Docker Build Image

If you want to build the docker image by yourself, you can use following command.

    docker build -t android-build-box .


## Contribution

If you want to enhance this docker image for fix something, feel free to send [pull request](https://github.com/boris-penev/docker-android-hdt/pull/new/master).


## References

* [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
* [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
* [Build your own image](https://docs.docker.com/engine/getstarted/step_four/)
* [uber android build environment](https://hub.docker.com/r/uber/android-build-environment/)
* [Refactoring a Dockerfile for image size](https://blog.replicated.com/2016/02/05/refactoring-a-dockerfile-for-image-size/)
