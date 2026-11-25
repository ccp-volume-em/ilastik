# ilastik
Container images for [ilastik](https://github.com/ilastik/ilastik),
the interactive learning and segmentation toolkit, 
maintained by the Rosalind Franklin Institute and the Collaborative
Computational Project for Volume Electron Microscopy (CCP-volumeEM).

Documentation for using the container: [rosalindfranklininstitute.github.io/volume-em-container-documentation/software/ilastik/](https://rosalindfranklininstitute.github.io/volume-em-container-documentation/software/ilastik)

## Images

Images are published to
[quay.io/repository/ccp-volume-em/ilastik](https://quay.io/repository/ccp-volume-em/ilastik).

| Tag | Description |
|---|---|
| `<ilastik>-cpu` | ilastik version, CPU build |
| `<ilastik>-gpu` | ilastik version, GPU-enabled build |
| `<ilastik>-gpu-vgl` | ilastik version, GPU-enabled build with VirtualGL |
| `latest` | The most recent `<ilastik>-cpu` build |

The GPU-enabled builds are distributed with NVidia's CUDA toolkit.

## Building a new image version

The images are built and pushed by the GitHub Actions workflow
`.github/workflows/build-publish.yml`, run manually with an ilastik version specified.

### Maintainence
Occasionally, action versions in the GitHub workflow may need updating.

### Verifying signatures

Images are signed in the build workflow using [cosign](https://docs.sigstore.dev/cosign/) keyless signing. To verify a particular `<tag>`:

```bash
cosgin verify quay.io/ccp-volume-em/ilastik:<tag> \
  --certificate-identity "https://github.com/ccp-volume-em/ilastik/.github/workflows/build-publish.yml@refs/heads/main" \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

## Licence

ilastik and the files in this repository are released under a GPL license. By using the
GPU-enabled builds, you also accept the terms and conditions of the [CUDA EULA](https://docs.nvidia.com/cuda/eula/index.html).
