# A blink-led example for R5F102AA (RL78/G12)
The firmware blinks an LED connected to P20 (pin #1).
The target MCU is R5F102AA ([RL78/G12](https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rl78-low-power-8-16-bit-mcus/rl78g12-compact-low-power-microcontrollers-general-purpose-applications-ideal-sub-mcus) in LSSOP-30)

# Building

## Using Docker

```
docker run --rm -v "$(pwd):/src" msalau/rl78-elf-llvm make
```
or
```
./build.sh
```

## Using a local rl78-llvm toolchain
```
export CC=<path-to-rl78-llvm>/bin/clang
export OBJCOPY=<path-to-rl78-llvm>/bin/llvm-objcopy
export OBJDUMP=<path-to-rl78-llvm>/bin/llvm-objdump
make
```
or
```
PATH=<path-to-rl78-llvm>/bin/:${PATH} make
```

# GitHub Actions Integration
A CI workflow to build the firmware in a Docker container which has LLVM for RL78 in it.

The image from Docker Hub used: [msalau/rl78-elf-llvm](https://hub.docker.com/r/msalau/rl78-elf-llvm)

The final SRecord image is saved in artifacts.
