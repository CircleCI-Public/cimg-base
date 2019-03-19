# CircleCI Docker Image `cimg/base` [![CircleCI Build Status](https://circleci.com/gh/cci-images/base.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/cci-imagess/base) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/cci-images/base/master/LICENSE)

The CircleCI Docker Base Image (`cimg/base`) is a lightweight Docker image with the minimal set of tools necessary to run a build on CircleCI.


## Purpose

All of CircleCI's language and service images are based on this image.
If you'd like to build your own CircleCI Docker image, you can base your image off of this one with the following line in your `Dockerfile`:

```
FROM cimg/base:stable
```

You can also use this image directly in CircleCI if you need a light-weight image to run generic commands or orb-based commands.


## Tags

`:<year>.<month>` - The monthly release for this image.
Any new or removed tools from the base image in the last 31 days will be reflected during this image release.
For example, the `2019.04` image will include any changes to this repo/image that occurred from March 1 - 31st, 2019.
Monthly releases are built on the 2nd of every month.

`:latest` - An alias for the most recent monthly release.
For example, if today's date was April 15th, 2019, then the `:latest` tag would be an alias for the `:2019.04` tag.

`:edge` - The latest changes to this Docker image that's available in the `master` branch of this repo.


## Resources

[CircleCI Docker Image Docs]: https://circleci.com/docs/2.0/circleci-images/#section=configuration
[Docker Docs]: https://docs.docker.com/engine/docker-overview/

## Development

Working on CircleCI Docker Images.

### Contributing
We welcome [issues](https://github.com/cci-images/base/issues) to and [pull requests](https://github.com/cci-images/base/pulls) against this repository!

### Publishing
Merging to `master` publishes a new image to the `edge` tag.
The Scheduled Workflow promotes `edge` to a `<year>.<month>` tag on the 2nd of every month.
The month tags can be manually updated due to security fixes or severe bugs via a Git Tag matching the Docker tag.


This image is maintained by the Community & Partner Engineering Team.
