## About
appimagelight is a modified version of appimagetool for my own personal needs.
It is useful for creating bare packages as it removes the requirement for .desktop entries and application icons.

It is especially useful if used as a wrapper. For example, for a JVM jar and runner.

### Disclaimer
This fork was thrown together pretty quickly, so don’t be surprised if you run into some weird bugs, or it doesn't work how you expect. This is NOT production-ready and I do not recommend using it unless you know exactly what you're doing!

## Usage

`appimagelight` is used to generate an AppImage from an existing `AppDir`.

Usage in a nutshell, assuming that you already have an [AppDir](https://github.com/AppImage/AppImageSpec/blob/master/draft.md#appdir) in place:

```
ARCH=x86_64 ./appimagelight someinput.AppDir someoutput
```

Detailed usage:
```
Usage:
  appimagelight [OPTION...] SOURCE [DESTINATION] - Generate AppImages from existing AppDirs

Help Options:
  -h, --help                  Show help options

Application Options:
  -l, --list                  List files in SOURCE AppImage
  -u, --updateinformation     Embed update information STRING; if zsyncmake is installed, generate zsync file
  -g, --guess                 Guess update information based on environment variables set by common CI systems (GitHub actions, GitLab CI)
  --version                   Show version number
  -v, --verbose               Produce verbose output
  -s, --sign                  Sign with gpg[2]
  --comp                      Squashfs compression
  -n, --no-appstream          Do not check AppStream metadata
  --exclude-file              Uses given file as exclude file for mksquashfs, in addition to .appimageignore.
  --runtime-file              Runtime file to use
  --sign-key                  Key ID to use for gpg[2] signatures
  --sign-args                 Extra arguments to use when signing with gpg[2]
```

### Environment variables

Some of the parameters above can alternatively be specified as environment variables. Also, some additional environment variables are available, too.
Please note they have been updated from the original appimagetool environment variables for ease of use.

- `ARCH`: Needs to be set whenever appimagelight cannot automatically determine the architecture of the binaries inside the AppDir to choose a suitable runtime (e.g., when binaries for multiple architectures or just shell scripts are contained in there).
- `APP_NAME`: If no destination is set by the user, appimagelight automatically generates a suitable output filename, using the root desktop entry's `Name` field. With this environment variable, this value can be set explicitly by the user.
- `SIGN_PASSPHRASE`: If the `--sign-key` is encrypted and requires a passphrase to be used for signing (and, for some reason, GnuPG cannot be used interactively, e.g., in a CI environment), this environment variable can be used to safely pass the key.
- `VERSION`: This value will be inserted by appimagelight into the root desktop file and (if the destination parameter is not provided by the user) in the output filename.

## Building

### Install prerequisite libraries:
#### Debian:
```
sudo apt install libglib2.0-dev zlib1g-dev libfuse-dev libcurl4-openssl-dev libgcrypt20-dev libgpgme-dev zsync squashfs-tools
```
#### Fedora:
```
sudo dnf install glib2-devel zlib-devel fuse-devel libcurl-devel libgcrypt-devel gpgme-devel zsync squashfs-tools
```
#### SUSE:
```
sudo zypper install glib2-devel zlib-devel fuse-devel libcurl-devel libgcrypt-devel gpgme-devel zsync squashfs appstream
```
### Build using script
```
sh build.sh
```
### Build manually
```
mkdir build && cd build
```
```
cmake ..
```
```
make appimagelight
```
*Will output to PROJECTROOT/build/src/appimagelight
## Credits
Credit and thank you to original project by AppImage team
