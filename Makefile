PROJECT := blink-led

CC ?= clang
OBJCOPY ?= llvm-objcopy
OBJDUMP ?= llvm-objdump

TARGET_FLAGS = --target=rl78 -mcpu=s2
CPPFLAGS = -Isrc -Igenerate -MMD -MP -MF$(@:.o=.d) -MT$@
CFLAGS = $(TARGET_FLAGS) -Os -ffunction-sections -fdata-sections -fdiagnostics-parseable-fixits -g -fstack-size-section $(CPPFLAGS)
LDFLAGS = $(TARGET_FLAGS) -T generate/linker_script.ld -Wl,-Map=$@.map -Wl,--start-group -Wl,--end-group -nostartfiles -Wl,-e_PowerON_Reset -Wl,-cref -Wl,--icf=none

SRCS := \
	./src/r5f102aa_llvm.c \
	./generate/vects.c \
	./generate/hwinit.c \
	./generate/inthandler.c \
	./generate/start.S

OBJS := $(addprefix build/,$(addsuffix .o,$(SRCS)))
DEPS := $(OBJS:.o=.d)
DIRS := $(sort $(dir $(OBJS)))

.PHONY: all clean

all: build/$(PROJECT).srec build/$(PROJECT).lst

clean:
		rm -rf build

%.srec: %.elf
		$(OBJCOPY) $< -O srec $@

%.lst: %.elf
		$(OBJDUMP) -dS $< > $@

build/$(PROJECT).elf build/$(PROJECT).cref: $(OBJS)
		$(CC) $(LDFLAGS) $^ -o build/$(PROJECT).elf > build/$(PROJECT).cref

build/%.c.o: %.c | $(DIRS)
		$(CC) $(CFLAGS) $< -c -o $@

build/%.S.o: %.S | $(DIRS)
		$(CC) -x assembler-with-cpp $(CFLAGS) $< -c -o $@

$(DIRS):
		mkdir -p $@

-include $(wildcard $(DEPS))
