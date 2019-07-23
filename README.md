# `cimg/base` [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/cimg-base.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/cimg-base) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/CircleCI-Public/cimg-base/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/images)

The CircleCI Docker Base Image (`cimg/base`) is a lightweight Ubuntu-base Docker image with the minimal set of tools necessary to run a build on CircleCI.


## Purpose

All of CircleCI's language and service images are based on this image.
If you'd like to build your own CircleCI Docker image, you can base your image off of this one with the following line in your `Dockerfile`:

```
FROM cimg/base:stable
```

You can also use this image directly in CircleCI if you need a light-weight image to run generic commands or orb-based commands.

## Variants

Currently, there is only a Node variant of this image. The Node variant includes the latest LTS version of Node, [installed via the `n` Node version manager](https://github.com/tj/n). To use a different Node version, see [Installing/Activating Node Versions](https://github.com/tj/n#installingactivating-node-versions), or use [CircleCI's Node orb](http://circleci.com/orbs/registry/orb/circleci/node#commands-install-node) to manually install a different version of Node. See below for explanation of specific `-node` (and other) tags.

## Tags

### `<year>.<month>`, `<year>.<month>-node`
Mostly immutable (except in the case of CVEs or severe bugs) monthly release tags for this image and its Node variant. Any new or removed tools from the base image in the last month will be reflected in this image release. For example, the `2019.04`/`2019.04-node` tags will include any changes to this repo/image that occurred in March 2019. Monthly releases are built on the 2nd of every month.

### `stable`, `stable-node`
Mutable tags representing the most recent monthly release of this image and its Node variant. For example, if today's date was April 15th, 2019, then the `stable`/`stable-node` tags would be aliases for the `2019.04`/`2019.04-node` tags.

### `edge`, `edge-node`
Mutable tags representing the builds of this image and its Node variant following the most recent successful commit to this repository's `master` branch.

### `latest`
Mutable tag that represents the latest non-Node-variant, vanilla `cimg/base` image, functionally duplicating whichever is the more recent of the `edge` and `stable` tags. Anyone calling the `cimg/base` image without specifying a tag will get this version of the image.


## Resources

[CircleCI Docker Image Docs]: https://circleci.com/docs/2.0/circleci-images/#section=configuration
[Docker Docs]: https://docs.docker.com/engine/docker-overview/

## Development

Working on CircleCI Docker Images.

### Commits to non-master branches
Upon successful commits to non-master branches of this repository, this image and its Node variant will be pushed to `ccitest/base` for any requisite post-deployment testing. Tags there will represent the branch and commit hash that triggered them. For example, a successful commit to a branch of this repository called `dev` would result in the creation of the following image/tag: `ccitest/base:dev-${CIRCLE_SHA1:0:7}"`, where `${CIRCLE_SHA1:0:7}"` represents the first six characters of that particular commit hash.

### Patching bugs and vulnerabilities
Monthly release tags can be manually re-published to patch vulnerabilities or severe bugs via a pushing a `git` tag that contains the string `monthly`. This tag will trigger a workflow that will rebuild all current `<year>.<month>` and `<year>.<month>-node` tags, as well as the `stable`, `stable-node`, and `latest` alias tags.

### Contributing
We welcome [issues](https://github.com/CircleCI-Public/cimg-base/issues) to and [pull requests](https://github.com/CircleCI-Public/cimg-base/pulls) against this repository!

This image is maintained by the Community & Partner Engineering Team.
