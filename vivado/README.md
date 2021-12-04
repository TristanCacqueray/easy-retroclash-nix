# Vivado toolchain setup for clash-shake

Unfortunately Symbiflow is difficult to use with the Nexys A7 board, so here are some instructions to setup Vivado:

In a CentOS-7 VM, follow: https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-sdk
Then extract the rootfs with:

```
mount -o loop,offset=$[ 2048 * 512 ] vivado.img loop
rsync -a rootfs/ /var/home/vivado/
```

Setup the build.mk with:

```
echo VIVADO = $(pwd)/run.py
```
