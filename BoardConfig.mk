#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

BOARD_VENDOR := htc

# Architecture
TARGET_USES_AOSP := true
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := kryo

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := SDM660
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 user_debug=31 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1 service_locator.enable=1 swiotlb=1 androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 androidboot.hardware=htc_ocl androidkey.dummy=1 buildvariant=eng
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096

TARGET_PREBUILT_KERNEL := device/htc/ocluhl/prebuilt/Image.gz-dtb

# Platform
TARGET_BOARD_PLATFORM := sdm660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno508

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3938451456
BOARD_USERDATAIMAGE_PARTITION_SIZE := 16719544320
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
AB_OTA_UPDATER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

# TWRP specific build flags
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_REPACKTOOLS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_HAS_DOWNLOAD_MODE := true
TW_THEME := portrait_hdpi
TW_NO_EXFAT_FUSE := true
TARGET_RECOVERY_DEVICE_MODULES := chargeled tzdata
TARGET_RECOVERY_DEVICE_MODULES += android.hardware.boot@1.0 hwservicemanager servicemanager libxml2 keystore libicuuc android.hidl.base@1.0
TW_RECOVERY_ADDITIONAL_RELINK_FILES := $(OUT)/system/lib64/android.hardware.boot@1.0.so $(OUT)/system/usr/share/zoneinfo/tzdata $(OUT)/system/bin/hwservicemanager $(OUT)/system/bin/servicemanager $(OUT)/system/lib64/libxml2.so $(OUT)/system/lib64/hw/keystore.default.so $(OUT)/system/lib64/libicuuc.so $(OUT)/system/lib64/android.hidl.base@1.0.so
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_NO_SCREEN_BLANK := true
TW_USE_LEDS_HAPTICS := true
#TW_USE_TOOLBOX := true
# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    vbmeta \
    dtbo 

# Custom Platform Version and Security Patch
# TWRP Defaults
#PLATFORM_VERSION := 16.1.0
#PLATFORM_SECURITY_PATCH := 2025-12-05
# Must match build.prop of current system for vold decrypt to work properly!
#PLATFORM_VERSION := 9
#PLATFORM_SECURITY_PATCH := 2018-12-01

# Encryption
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
#TW_CRYPTO_USE_SYSTEM_VOLD := hwservicemanager servicemanager qseecomd keymaster-3-0
#TW_CRYPTO_SYSTEM_VOLD_MOUNT := vendor

## additional twrp flags ##
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_REPACKTOOLS := true
USE_RECOVERY_INSTALLER := true
RECOVERY_INSTALLER_PATH := device/htc/ocluhl/installer
TW_HAS_EDL_MODE := true

# TWRP Debug Flags
#TWRP_EVENT_LOGGING := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
#TARGET_RECOVERY_DEVICE_MODULES += debuggerd # strace
#TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(OUT)/system/bin/debuggerd # $(OUT)/system/xbin/strace
#TARGET_RECOVERY_DEVICE_MODULES += twrpdec
#TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrpdec
TW_CRYPTO_SYSTEM_VOLD_DEBUG := true
