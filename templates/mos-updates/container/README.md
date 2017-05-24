# mk-updates-tarball

`mk-updates-tarball` generates a compressed rpm repository with packages
fetched from upstream CentOS mirrors that are newer then packages available
in MOS repositories.

## Usage

```
mk-updates-tarball [OPTIONS] <-i <ISO>|-r <RELEASE>>
```

## Options

* `-a|--append <tarball>` - append downloaded packages to existing tarball
* `-A|--auto` - automatically generate packages that are newer in upstream
  and download them
* `-b|--blacklist-append` - append item to blacklist
* `-B|--blacklist-replace` - replace blacklist completely
* `-o|--out-file <tarball>` - output tarball filename (with .tar.gz extension).
  If not specified then default `updates.tar.gz` is used.
* `-i|--iso` - Mirantis ISO, should be located in the working directory
* `-r|--release` - Mirantis release for which to download packages. Available
  releases are `mos7`, `mos8`, `mos9`.
* `-R|--resolve-srpm` - when resolving packages add to download list all binary
  packages that were build from the same source package as requested. E.g. if
  only `openssh` is requested then every package produced from its source will
  be added to the download list, even if they are not dependencies for `openssh`
* `-h|--help` - help
* `-l|--list <filename>` - load list of packages to download from `<filename>`
* `-f|--file <filename>` - load list of packages to download from `<filename>`.
  In this case names are RPM package names.

## Examples

### Sync all packages that are newer in upstream

```
mk-updates-tarball -A -r <release name> -o <tarball name>.tar.gz
```

### Fetch updates for a package(s)

```
mk-updates-tarball -r <release name> -o <tarball name>.tar.gz <package(s)>
```

