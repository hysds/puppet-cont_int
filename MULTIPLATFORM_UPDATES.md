# Multi-Platform Build Updates for puppet-cont_int

## Summary
Updated `build_docker.sh` to support building multi-platform container images for both **linux/amd64** (x86_64) and **linux/arm64** (ARM64/aarch64) architectures.

## Changes Made

### 1. build_docker.sh
**File**: `build_docker.sh`

Added conditional logic to support both standard Docker builds and multi-platform buildx builds:

- **Environment Variables**:
  - `USE_BUILDX=1` - Enables multi-platform build mode
  - `DOCKER_BUILDX_PLATFORM` - Specifies target platforms (default: "linux/amd64,linux/arm64")

- **Behavior**:
  - When `USE_BUILDX=1`: Uses `docker buildx build` with `--platform` flag and `--push`
  - Otherwise: Uses standard `docker build` (backward compatible)

**Builds one image:**
- `hysds/cont_int:${TAG}` - Multi-stage build:
  - Stage 1: Extends `hysds/dev`, installs HySDS framework and CI components
  - Stage 2: Extends `hysds/base`, copies artifacts and configures continuous integration

**Example Usage**:
```bash
# Standard build (x86_64 only)
./build_docker.sh latest hysds develop develop develop latest develop

# Multi-platform build
export USE_BUILDX=1
export DOCKER_BUILDX_PLATFORM="linux/amd64,linux/arm64"
./build_docker.sh latest hysds develop develop develop latest develop
```

### 2. docker/Dockerfile - No Changes Required ✅

The Dockerfile is already multi-platform compatible:
- Multi-stage build extends `hysds/dev` and `hysds/base`
- No architecture-specific commands
- No hardcoded x86_64 references

### 3. manifests/ - No Changes Required ✅

No architecture-specific configurations found in manifests.

## Prerequisites

### Base Images Must Be Multi-Platform

This repository depends on multi-platform base images from upstream repositories:
- ✅ `hysds/dev:${TAG}` - From puppet-hysds_dev
- ✅ `hysds/base:${TAG}` - From puppet-hysds_base

Ensure these base images are built and pushed as multi-platform before building cont_int.

## Build Order

The correct build order for multi-platform images:

1. **puppet-hysds_base**: Build base image
   ```bash
   cd /path/to/puppet-hysds_base
   export USE_BUILDX=1
   export DOCKER_BUILDX_PLATFORM="linux/amd64,linux/arm64"
   ./build_docker.sh latest hysds develop
   ```

2. **puppet-hysds_dev**: Build dev image
   ```bash
   cd /path/to/puppet-hysds_dev
   export USE_BUILDX=1
   export DOCKER_BUILDX_PLATFORM="linux/amd64,linux/arm64"
   ./build_docker.sh latest hysds develop
   ```

3. **puppet-cont_int**: Build cont_int image
   ```bash
   cd /path/to/puppet-cont_int
   export USE_BUILDX=1
   export DOCKER_BUILDX_PLATFORM="linux/amd64,linux/arm64"
   ./build_docker.sh latest hysds develop develop develop latest develop
   ```

## Image Hierarchy

```
hysds/base (puppet-hysds_base)
  └── hysds/dev (puppet-hysds_dev)
        └── [stage 1] → hysds/cont_int (puppet-cont_int)
```

Note: cont_int uses a multi-stage build where stage 1 extends the dev image to install software, then stage 2 extends the base image and copies artifacts from stage 1.

## Testing Checklist

### Build Testing
- [ ] Standard build works without USE_BUILDX
- [ ] Multi-platform build works with buildx enabled
- [ ] cont_int image builds successfully
- [ ] Image is pushed to registry with correct manifest

### Runtime Testing
- [ ] **x86_64**: Pull and run image on x86_64 host
  ```bash
  docker run --platform linux/amd64 hysds/cont_int:test python --version
  docker run --platform linux/amd64 hysds/cont_int:test supervisord --version
  ```
- [ ] **ARM64**: Pull and run image on ARM64 host
  ```bash
  docker run --platform linux/arm64 hysds/cont_int:test python --version
  docker run --platform linux/arm64 hysds/cont_int:test supervisord --version
  ```

### Component-Specific Testing
- [ ] Verify CI components are installed correctly
- [ ] Test Jenkins/CI integration
- [ ] Verify supervisord configuration

## Verify Multi-platform Image

After building, verify both architectures are present:

```bash
docker buildx imagetools inspect hysds/cont_int:latest
```

Expected output should show manifests for both:
- Platform: linux/amd64
- Platform: linux/arm64

## Build Secrets

The build script uses Docker BuildKit secrets for GitHub OAuth tokens:
- Secret ID: `git_oauth_token`
- Source: `$HOME/.git_oauth_token`
- Used to bypass GitHub API rate limits during builds

This works with both standard builds and buildx builds.

## Rollback Plan

If issues arise, revert to single-platform builds by:
1. Not setting `USE_BUILDX=1` environment variable
2. The script will automatically use standard `docker build` commands

## Known Limitations

1. **Build Time**: Multi-platform builds take significantly longer (2x+ time)
2. **Multi-stage Complexity**: The cont_int image uses multi-stage builds which may require more memory
3. **Base Image Dependency**: Requires all upstream multi-platform base images to be available

## Related Files

This repository's changes work in conjunction with:
- `/Users/mcayanan/git/puppet-hysds_base/` - Base image repository (build first)
- `/Users/mcayanan/git/puppet-hysds_dev/` - Dev image repository (build second)
- `/Users/mcayanan/git/hysds-framework/.circleci/config.yml` - CircleCI configuration
- `/Users/mcayanan/git/hysds-framework/.circleci/MULTIPLATFORM_BUILD_NOTES.md` - Overall strategy

## Additional Notes

- The multi-stage build in the Dockerfile works seamlessly with buildx
- Architecture detection happens automatically during buildx
- Docker automatically pulls the correct architecture when running containers
- Images are tagged once but contain manifests for multiple architectures
- No changes to application code are required
- This is one of the cleanest multi-platform updates with no architecture-specific dependencies
