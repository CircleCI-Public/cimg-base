<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://raw.github.com/CircleCI-Public/cimg-base/master/img/circle-circleci.svg?sanitize=true" width="75" />
		<img alt="Docker Logo" src="https://raw.github.com/CircleCI-Public/cimg-base/master/img/circle-docker.svg?sanitize=true" width="75" />
		<img alt="Ubuntu Logo" src="https://raw.github.com/CircleCI-Public/cimg-base/master/img/circle-ubuntu.svg?sanitize=true" width="75" />
	</p>
	<h1>CircleCI Convenience Images => Base</h1>
	<h3>A Continous Integration focused Ubuntu Docker image built to run on CircleCI</h3>
</div>

[![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/cimg-base.svg?style=shield)](https://circleci.com/gh/CircleCI-Public/cimg-base) [![Software License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/CircleCI-Public/cimg-base/master/LICENSE) [![Docker Pulls](https://img.shields.io/docker/pulls/cimg/base)](https://hub.docker.com/r/cimg/base) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/circleci-images)

`cimg/base` is an Ubuntu Docker image created by CircleCI with continuous integration builds in mind.
As its name suggests, this image is designed to serve as a base image for other CircleCI Convenience Images (images prefixed with `cimg/`).

This image is also very useful for CircleCI users to use as a base for their own custom Docker images.

This image contains the minimum tools required to operate a build on CircleCI (such as `git`) as well as extremely popular and useful tools in CircleCI (such as `docker`).


## Table of Contents

- [Getting Started](#getting-started)
- [How This Image Works](#how-this-image-works)
- [Development](#development)
- [Contributing](#contributing)
- [Additional Resources](#additional-resources)
- [License](#license)


## Getting Started

This image can be used with the CircleCI `docker` executor.
For example:

```yaml
jobs:
  build:
    docker:
      - image: cimg/base:2020.12
    steps:
      - checkout
      # Whatever you want to do
      - run: sudo apt-get update && sudo apt-get install -y cowsay
      - run: cowsay Continuous Integration Rocks!
```

In the above example, the CircleCI Base Docker image is used for the primary container.
More specifically, the tag `2020.12` indicates the dated version of the base image.
See how tags work below for more information.


## How This Image Works

This image contains the Ubuntu Linux operating system and everything needed to run most builds on CircleCI.
This includes but is not limited to:

- Git
- Docker and Docker Compose
- Dockerize
- The `build-essential` package containing compiling tools
- jq
- curl, ssh, and much more

### Tagging Scheme

This image has the following tagging scheme:

```
cimg/base:edge[-version]
cimg/base:stable[-version] 
cimg/base:<YYYY.MM>[-version] 
```

`edge` - This image tag points to the latest version of the Base image.
This tag is built from the `HEAD` of the `master` branch.
The `edge` tag is intended to be used as a testing version of the image with the most recent changes however not guaranteed to be all that stable.
This tag is not recommended for production software.

`stable` - This image tag points to the latest, production ready base image.
This image should be used by projects that want a decent level of stability but would like to get occasional software updates.
It is typically updated once a month.

`<YYYY.MM>` - This image tag is a monthly snapshot of the image, referred to by the 4 digit year, dot, and a 2 digit month.
For example `2019.09` would be the monthly snapshot tag from September 2019.
This tag is intended for projects that are highly sensitive to changes and want the most deterministic builds possible.

`-version` - This is an optional extension to the tag to specify the version of Ubuntu to use.
There can be up to two options, the current LTS and the previous LTS.
As of this writing, those options would be `18.04` or `20.04`.
When leaving the version out, suggested, the default version will be used.
The default Ubuntu version is the newest LTS version, after it has been out for 2 months.
For example, Ubuntu 20.04 came out in April 2020, so it became the default version for this image in June 2020.
The previous LTS version will be supported for a year after it drops out of the default slot.


## Development

Images can be built and run locally with this repository.
This has the following requirements:

- local machine of Linux (Ubuntu tested) or macOS
- modern version of Bash (v4+)
- modern version of Docker Engine (v19.03+)

### Cloning For Community Users (no write access to this repository)

Fork this repository on GitHub.
When you get your clone URL, you'll want to add `--recurse-submodules` to the clone command in order to populate the Git submodule contained in this repo.
It would look something like this:

```bash
git clone --recurse-submodules <my-clone-url>
```

If you missed this step and already cloned, you can just run `git submodule update --recursive` to populate the submodule.
Then you can optionally add this repo as an upstream to your own:

```bash
git remote add upstream https://github.com/CircleCI-Public/cimg-base.git
```

### Cloning For Maintainers ( you have write access to this repository)

Clone the project with the following command so that you populate the submodule:

```bash
git clone --recurse-submodules git@github.com:CircleCI-Public/cimg-base.git
```

### Generating Dockerfiles

The Dockerfile in the Ubuntu version directory (i.e. `18.04/`) is already in a state to be built if you want to build a new version of this image.
Running `docker build` in this directory will be enough.

Changes to this image should occur in the `Dockerfile.template` file and then using the `gen-dockerfiles.sh` script, a new Dockerfile will be built.
For example, you would run the following from the root of the repo:

```bash
./shared/gen-dockerfiles.sh 18.04 20.04
```

The generated Dockerfile will be located at `./18.04/Dockefile` and `./20.04/Dockerfile`.
To build the first image locally and try it out, you can run the following:

```bash
cd 18.04
docker build -t test/base:18.04 .
docker run -it test/base:18.04 bash
```

While CircleCI will only be publishing LTS versions of Ubuntu (such as 18.04 or 20.04), you are free to swap out the version number with something newer for your own personal use.

### Building the Dockerfiles

To build the Docker images locally as this repository does, run the `build-images.sh` script:

```bash
./build-images.sh
```

This script needs to be run after generating the Dockerfiles first.
When releasing proper images for CircleCI, this script is run from a CircleCI pipeline and not locally.

### Publishing Official Images (for Maintainers only)

The individual scripts (above) can be used to create the correct files for an image, and then added to a new git branch, committed, etc.
`stage` and `edge` releases are completely automated as in the monthly snapshots.
The release script is included to make this process easier for LTS updates.
To make an updated LTS release for this image, you would run the following from the repo root:

```bash
./shared/release.sh 20.04
```

This will automatically create a new Git branch, generate the Dockerfile(s), stage the changes, commit them, and push them to GitHub.
All that would need to be done after that is:

- wait for build to pass on CircleCI
- review the PR
- merge the PR

The master branch build will then publish a release.
`edge` will be updated immediately with the LTS change occurring during the next monthly release.

### Incorporating Changes

How changes are incorporated into this image depends on where they come from.

**build scripts** - Changes within the `./shared` submodule happen in its [own repository](https://github.com/CircleCI-Public/cimg-shared).
For those changes to affect this image, the submodule needs to be updated.
Typically like this:

```bash
cd shared
git pull
cd ..
git add shared
git commit -m "Updating submodule for foo."
```

**Base specific changes** - Editing the `Dockerfile.template` file in this repo will modify the Go image, specifically.
Don't forget that to see any of these changes locally, the `gen-dockerfiles.sh` script will need to be run again (see above).

### Fixing a Monthly Snapshot

You can respin (re-release) a monthly snapshot where there's a serious bug or security issue.
This can be done by tagging a commit as `monthly`.
This will re-create the monthly snapshot for the current month.


## Contributing

We encourage [issues](https://github.com/CircleCI-Public/cimg-base/issues) and [pull requests](https://github.com/CircleCI-Public/cimg-base/pulls) against this repository. In order to value your time, here are some things to consider:

1. We won't include just anything in this image. In order for us to add a tool within the base image, it has to be something that is maintained and useful to a majority of CircleCI users. Every tool added makes the image larger and slower for all users, so being thorough on what goes in the image will benefit everyone.
1. PRs are welcome. If you have a PR that will potentially take a large amount of time to make, it will be better to open an issue to discuss it first to make sure it's something worth investing the time in.
1. Issues should be used to report bugs or request additional/removal of tools in this image. For help with images, please visit [CircleCI Discuss](https://discuss.circleci.com/c/ecosystem/circleci-images).


## Additional Resources

[CircleCI Docs](https://circleci.com/docs/) - The official CircleCI Documentation website.  
[CircleCI Configuration Reference](https://circleci.com/docs/2.0/configuration-reference/#section=configuration) - From CircleCI Docs, the configuration reference page is one of the most useful pages we have.
It will list all of the keys and values supported in `.circleci/config.yml`.  
[Docker Docs](https://docs.docker.com/) - For simple projects this won't be needed but if you want to dive deeper into learning Docker, this is a great resource.  


## License

This repository is licensed under the MIT license.
The license can be found [here](./LICENSE).
