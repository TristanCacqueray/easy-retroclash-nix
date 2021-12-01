# Symbiflow toolchain for the Nexys A7-50T board

Build the image with:

```
TMPDIR=/tmp/podman podman build -t symbiflow-centos .
```

Setup the build.mk with:

```
echo SYMBIFLOW = $(pwd)/run > ~/src/github.com/gergoerdi/clash-pong
```

Build the clash-pong:

```
shake --symbiflow nexys-a7-50t/bitfile
ls -la _build/nexys-a7-50t/Top.bit
```
