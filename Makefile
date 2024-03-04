# Directories
MSPGCC_ROOT_DIR = C:\ti\msp430-gcc-9.3.1.11_win64
MSPGCC_BIN_DIR = $(MSPGCC_ROOT_DIR)/bin
MSPGCC_INCLUDE_DIR = $(MSPGCC_ROOT_DIR)/include
INCLUDE_DIRS = $(MSPGCC_INCLUDE_DIR)
LIB_DIRS = $(MSPGCC_INCLUDE_DIR)
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = $(BUILD_DIR)/bin
#TI_CCS_DIR = /mnt/c/ti/ccs1220/ccs
#DEBUG_BIN_DIR = $(TI_CCS_DIR)/css_base/DebugServer/bin
#DEBUG_DRIVERS_DIR = $(TI_CCS_DIR)/css_base/DebugServer/drivers
MSP_FLASHER = C:\ti\MSPFlasher/MSP430Flasher.exe

# Toolchain
CC = $(MSPGCC_BIN_DIR)/msp430-elf-gcc
#DEBUG = LD_LIBRARY_PATH=$(DEBUG_DRIVERS_DIR) $(DEBUG_BIN_DIR)/mspdebug

# Files
TARGET = $(BIN_DIR)/blink

SOURCES = main.c \
          led.c
# $(wildcard *.c) takes all the .c files

OBJECT_NAMES = $(SOURCES:.c=.o)
OBJECTS = $(patsubst %,$(OBJ_DIR)/%,$(OBJECT_NAMES))

# Flags
MCU = msp430fr6989
WFLAGS = -Wall -Wextra -Werror -Wshadow -Wdouble-promotion
CFLAGS = -mmcu=$(MCU) $(WFLAGS) $(addprefix -I,$(INCLUDE_DIRS)) -Og -g
LDFLAGS = -mmcu=$(MCU) $(addprefix -L,$(LIB_DIRS))

# Build
# $^ : Input
# $@ : Output
# @ in the beggining so to not print result in cmd
## Linking
$(TARGET): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) $^ -o $@

## Compiling
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^

# Phonies
.PHONY: all clean flash erase

all: $(TARGET) convert

clean:
	rm -f -r $(BUILD_DIR)
	rm -f -r Log

convert: 
	@msp430-elf-objcopy -O ihex $(BIN_DIR)/blink $(BIN_DIR)/blink.hex

flash: all
#	$(DEBUG) tilib  "prog $(TARGET)"
	$(MSP_FLASHER) -e ERASE_ALL -w $(BIN_DIR)/blink.hex -v -z [VCC]

erase:
	$(MSP_FLASHER) -e ERASE_ALL
