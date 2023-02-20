**This image is deprecated. One user of this image has recommended using `ubuntudesktop/gnome-3-38-2004` instead though I have not tried it myself.**

# CI Builds: Snapcraft Image [![CircleCI Build Status](https://circleci.com/gh/cibuilds/snapcraft.svg?style=shield)](https://circleci.com/gh/cibuilds/snapcraft) [![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/cibuilds/snapcraft/trunk/LICENSE)

Docker image containing [Snapcraft](https://snapcraft.io) (a Linux package management tool) designed to run well in Continuous Integration environments such as CircleCI.

This image is heavily inspired by an this image: [`kyrofa/github-snap-builder-docker`](https://github.com/kyrofa/github-snap-builder-docker).

## Usage

### Snaps Using a Base

This Docker image has tags based on which Snapcraft base you plan to use.
If your Snapcraft build is using the `core18` base for example, you'd want to use the image: `cibuilds/snapcraft:core18`.
If you're using the `core` snap, you'd use the `core` or `core16` Docker tag as they are aliases of each other.

### Classic Snaps

Classic snaps use the resources of the host.
You can use either of the Docker tags mentioned above (`core18` or `core16`) as each use Ubuntu as the distro, Ubuntu 18.04 or 16.04 respectively.
Which one you use will determine which Ubuntu archive (the packages and their versions) that will be available when building the snap.

Any `build-packages` needed for the snap will need to be installed in your CI runner (such as CircleCI) in order for Snapcraft to be able to use it fto build the snap.

### Baseless Snaps

This is deprecated by Snapcraft I believe.
If you're still using baseless snaps, try to switch to base.
If you still need to build a baseless snap, it is suggested to use the `core16` image tag to build.
Your full image name would be: `cibuilds/snapcraft:core16`.


## Deprecation

If you are a longtime user of this image you are likely using the `stable` or `latest` tags.
Neither of these tags are updated anymore and will likely be deleted sometime in the future.
Please read the "Usage" section above and find the new image tag you should be using.


An example of how to use this Snapcraft Docker image can be found in [CircleCI Docs](https://circleci.com/docs/2.0/build-publish-snap-packages/) but this resource is currently out of date.
