EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)

EXTRA_CFLAGS += -Wno-unused-variable
EXTRA_CFLAGS += -Wno-unused-value
EXTRA_CFLAGS += -Wno-unused-label
EXTRA_CFLAGS += -Wno-unused-parameter
EXTRA_CFLAGS += -Wno-unused-function
EXTRA_CFLAGS += -Wno-unused

EXTRA_CFLAGS += -Wno-uninitialized

EXTRA_CFLAGS += -I$(src)/include

CONFIG_AUTOCFG_CP = y

CONFIG_RTL8192C = n
CONFIG_RTL8192D = n
CONFIG_RTL8723A = n
CONFIG_RTL8188E = y

CONFIG_USB_HCI = y
CONFIG_PCI_HCI = n
CONFIG_SDIO_HCI = n
CONFIG_GSPI_HCI = n

CONFIG_MP_INCLUDED = n
CONFIG_POWER_SAVING = y
CONFIG_USB_AUTOSUSPEND = n
CONFIG_HW_PWRP_DETECTION = n
CONFIG_WIFI_TEST = n
CONFIG_BT_COEXIST = n
CONFIG_RTL8192CU_REDEFINE_1X1 = n
CONFIG_INTEL_WIDI = n
CONFIG_WAPI_SUPPORT = n
CONFIG_EFUSE_CONFIG_FILE = n
CONFIG_EXT_CLK = n
CONFIG_FTP_PROTECT = n
CONFIG_WOWLAN = n
CONFIG_GPIO_WAKEUP = n
CONFIG_ODM_ADAPTIVITY = n
CONFIG_MMC_PM_KEEP_POWER = n

CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ANDROID_X86 = n
CONFIG_PLATFORM_JB_X86 = n
CONFIG_PLATFORM_ARM_RPI = y
CONFIG_PLATFORM_ARM_S3C2K4 = n
CONFIG_PLATFORM_ARM_PXA2XX = n
CONFIG_PLATFORM_ARM_S3C6K4 = n
CONFIG_PLATFORM_MIPS_RMI = n
CONFIG_PLATFORM_RTD2880B = n
CONFIG_PLATFORM_MIPS_AR9132 = n
CONFIG_PLATFORM_RTK_DMP = n
CONFIG_PLATFORM_MIPS_PLM = n
CONFIG_PLATFORM_MSTAR389 = n
CONFIG_PLATFORM_MT53XX = n
CONFIG_PLATFORM_ARM_MX51_241H = n
CONFIG_PLATFORM_ACTIONS_ATJ227X = n
CONFIG_PLATFORM_TEGRA3_CARDHU = n
CONFIG_PLATFORM_TEGRA4_DALMORE = n
CONFIG_PLATFORM_ARM_TCC8900 = n
CONFIG_PLATFORM_ARM_TCC8920 = n
CONFIG_PLATFORM_ARM_TCC8920_JB42 = n
CONFIG_PLATFORM_ARM_RK2818 = n
CONFIG_PLATFORM_ARM_URBETTER = n
CONFIG_PLATFORM_ARM_TI_PANDA = n
CONFIG_PLATFORM_MIPS_JZ4760 = n
CONFIG_PLATFORM_DMP_PHILIPS = n
CONFIG_PLATFORM_TI_DM365 = n
CONFIG_PLATFORM_MSTAR_TITANIA12 = n
CONFIG_PLATFORM_MSTAR = n
CONFIG_PLATFORM_SZEBOOK = n
CONFIG_PLATFORM_ARM_SUNxI = n
CONFIG_PLATFORM_ARM_SUN6I = n
CONFIG_PLATFORM_ARM_SUN7I = n
CONFIG_PLATFORM_ACTIONS_ATM702X = n
CONFIG_PLATFORM_MN10300 = n
CONFIG_PLATFORM_ACTIONS_ATV5201 = n

CONFIG_DRVEXT_MODULE = n

export TopDIR ?= $(shell pwd)


OUTSRC_FILES := hal/OUTSRC/odm_debug.o	\
								hal/OUTSRC/odm_interface.o\
								hal/OUTSRC/odm_HWConfig.o\
								hal/OUTSRC/odm.o\
		hal/OUTSRC/HalPhyRf.o
										
ifeq ($(CONFIG_RTL8192C), y)
RTL871X = rtl8192c

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8192cu
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8192CUFWImg_CE.o	\
								hal/OUTSRC/$(RTL871X)/Hal8192CUPHYImg_CE.o	\
								hal/OUTSRC/$(RTL871X)/Hal8192CUMACImg_CE.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8192ce
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8192CEFWImg_CE.o	\
								hal/OUTSRC/$(RTL871X)/Hal8192CEPHYImg_CE.o	\
								hal/OUTSRC/$(RTL871X)/Hal8192CEMACImg_CE.o
endif

OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/odm_RTL8192C.o\
								hal/OUTSRC/$(RTL871X)/HalDMOutSrc8192C_CE.o

CHIP_FILES := \
	hal/$(RTL871X)/$(RTL871X)_sreset.o \
	hal/$(RTL871X)/$(RTL871X)_xmit.o
CHIP_FILES += $(OUTSRC_FILES)

endif

ifeq ($(CONFIG_RTL8192D), y)
RTL871X = rtl8192d

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8192du
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8192DUFWImg_CE.o \
								hal/OUTSRC/$(RTL871X)/Hal8192DUPHYImg_CE.o \
								hal/OUTSRC/$(RTL871X)/Hal8192DUMACImg_CE.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8192de
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8192DEFWImg_CE.o \
								hal/OUTSRC/$(RTL871X)/Hal8192DEPHYImg_CE.o \
								hal/OUTSRC/$(RTL871X)/Hal8192DEMACImg_CE.o
endif

OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/odm_RTL8192D.o\
								hal/OUTSRC/$(RTL871X)/HalDMOutSrc8192D_CE.o
CHIP_FILES := \
	hal/$(RTL871X)/$(RTL871X)_xmit.o
CHIP_FILES += $(OUTSRC_FILES)
endif

ifeq ($(CONFIG_RTL8723A), y)

RTL871X = rtl8723a

HAL_COMM_FILES := hal/$(RTL871X)/$(RTL871X)_xmit.o \
								hal/$(RTL871X)/$(RTL871X)_sreset.o

ifeq ($(CONFIG_GSPI_HCI), y)
MODULE_NAME = 8723as
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8723SHWImg_CE.o
endif

ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8723as
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8723SHWImg_CE.o
endif

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8723au
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8723UHWImg_CE.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8723ae
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/Hal8723EHWImg_CE.o
endif

#hal/OUTSRC/$(RTL871X)/HalHWImg8723A_FW.o
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/HalHWImg8723A_BB.o\
								hal/OUTSRC/$(RTL871X)/HalHWImg8723A_MAC.o\
								hal/OUTSRC/$(RTL871X)/HalHWImg8723A_RF.o\
								hal/OUTSRC/$(RTL871X)/odm_RegConfig8723A.o

OUTSRC_FILES += hal/OUTSRC/rtl8192c/HalDMOutSrc8192C_CE.o
clean_more ?=
clean_more += clean_odm-8192c

PWRSEQ_FILES := hal/HalPwrSeqCmd.o \
				hal/$(RTL871X)/Hal8723PwrSeq.o

CHIP_FILES += $(HAL_COMM_FILES) $(OUTSRC_FILES) $(PWRSEQ_FILES)

ifeq ($(CONFIG_BT_COEXIST), y)
CHIP_FILES += hal/$(RTL871X)/rtl8723a_bt-coexist.o
endif

endif

ifeq ($(CONFIG_RTL8188E), y)

RTL871X = rtl8188e
HAL_COMM_FILES := hal/$(RTL871X)/$(RTL871X)_xmit.o\
									hal/$(RTL871X)/$(RTL871X)_sreset.o

ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8189es
endif

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8188eu
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8188ee
endif

#hal/OUTSRC/$(RTL871X)/HalHWImg8188E_FW.o
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/HalHWImg8188E_MAC.o\
		hal/OUTSRC/$(RTL871X)/HalHWImg8188E_BB.o\
		hal/OUTSRC/$(RTL871X)/HalHWImg8188E_RF.o\
		hal/OUTSRC/$(RTL871X)/Hal8188EFWImg_CE.o\
		hal/OUTSRC/$(RTL871X)/HalPhyRf_8188e.o\
		hal/OUTSRC/$(RTL871X)/odm_RegConfig8188E.o\
		hal/OUTSRC/$(RTL871X)/Hal8188ERateAdaptive.o\
		hal/OUTSRC/$(RTL871X)/odm_RTL8188E.o

ifeq ($(CONFIG_RTL8188E), y)
ifeq ($(CONFIG_WOWLAN), y)
OUTSRC_FILES += hal/OUTSRC/$(RTL871X)/HalHWImg8188E_FW.o
endif
endif

PWRSEQ_FILES := hal/HalPwrSeqCmd.o \
				hal/$(RTL871X)/Hal8188EPwrSeq.o

CHIP_FILES += $(HAL_COMM_FILES) $(OUTSRC_FILES) $(PWRSEQ_FILES) 

endif


ifeq ($(CONFIG_GSPI_HCI), y)
HCI_NAME = gspi
endif

ifeq ($(CONFIG_SDIO_HCI), y)
HCI_NAME = sdio
endif

ifeq ($(CONFIG_USB_HCI), y)
HCI_NAME = usb
endif

ifeq ($(CONFIG_PCI_HCI), y)
HCI_NAME = pci
endif


_OS_INTFS_FILES :=	os_dep/osdep_service.o \
			os_dep/linux/os_intfs.o \
			os_dep/linux/$(HCI_NAME)_intf.o \
			os_dep/linux/$(HCI_NAME)_ops_linux.o \
			os_dep/linux/ioctl_linux.o \
			os_dep/linux/xmit_linux.o \
			os_dep/linux/mlme_linux.o \
			os_dep/linux/recv_linux.o \
			os_dep/linux/ioctl_cfg80211.o \
			os_dep/linux/rtw_android.o

ifeq ($(CONFIG_SDIO_HCI), y)
_OS_INTFS_FILES += os_dep/linux/custom_gpio_linux.o
_OS_INTFS_FILES += os_dep/linux/$(HCI_NAME)_ops_linux.o
endif

ifeq ($(CONFIG_GSPI_HCI), y)
_OS_INTFS_FILES += os_dep/linux/custom_gpio_linux.o
_OS_INTFS_FILES += os_dep/linux/$(HCI_NAME)_ops_linux.o
endif

_HAL_INTFS_FILES :=	hal/hal_intf.o \
			hal/hal_com.o \
			hal/$(RTL871X)/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)/$(RTL871X)_dm.o \
			hal/$(RTL871X)/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)/$(RTL871X)_cmd.o \
			hal/$(RTL871X)/$(HCI_NAME)/$(HCI_NAME)_halinit.o \
			hal/$(RTL871X)/$(HCI_NAME)/rtl$(MODULE_NAME)_led.o \
			hal/$(RTL871X)/$(HCI_NAME)/rtl$(MODULE_NAME)_xmit.o \
			hal/$(RTL871X)/$(HCI_NAME)/rtl$(MODULE_NAME)_recv.o

ifeq ($(CONFIG_SDIO_HCI), y)
_HAL_INTFS_FILES += hal/$(RTL871X)/$(HCI_NAME)/$(HCI_NAME)_ops.o
else
ifeq ($(CONFIG_GSPI_HCI), y)
_HAL_INTFS_FILES += hal/$(RTL871X)/$(HCI_NAME)/$(HCI_NAME)_ops.o
else
_HAL_INTFS_FILES += hal/$(RTL871X)/$(HCI_NAME)/$(HCI_NAME)_ops_linux.o
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)/$(RTL871X)_mp.o
endif

_HAL_INTFS_FILES += $(CHIP_FILES)


ifeq ($(CONFIG_AUTOCFG_CP), y)

ifeq ($(CONFIG_RTL8188E)$(CONFIG_SDIO_HCI),yy) 
$(shell cp $(TopDIR)/autoconf_rtl8189e_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
else
$(shell cp $(TopDIR)/autoconf_$(RTL871X)_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
endif
endif


ifeq ($(CONFIG_USB_HCI), y)
ifeq ($(CONFIG_USB_AUTOSUSPEND), y)
EXTRA_CFLAGS += -DCONFIG_USB_AUTOSUSPEND
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
#MODULE_NAME := $(MODULE_NAME)_mp
EXTRA_CFLAGS += -DCONFIG_MP_INCLUDED
endif

ifeq ($(CONFIG_POWER_SAVING), y)
EXTRA_CFLAGS += -DCONFIG_POWER_SAVING
endif

ifeq ($(CONFIG_HW_PWRP_DETECTION), y)
EXTRA_CFLAGS += -DCONFIG_HW_PWRP_DETECTION
endif

ifeq ($(CONFIG_WIFI_TEST), y)
EXTRA_CFLAGS += -DCONFIG_WIFI_TEST
endif

ifeq ($(CONFIG_BT_COEXIST), y)
EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
endif

ifeq ($(CONFIG_RTL8192CU_REDEFINE_1X1), y)
EXTRA_CFLAGS += -DRTL8192C_RECONFIG_TO_1T1R
endif

ifeq ($(CONFIG_INTEL_WIDI), y)
EXTRA_CFLAGS += -DCONFIG_INTEL_WIDI
endif

ifeq ($(CONFIG_WAPI_SUPPORT), y)
EXTRA_CFLAGS += -DCONFIG_WAPI_SUPPORT
endif

ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
EXTRA_CFLAGS += -DCONFIG_EFUSE_CONFIG_FILE
endif

ifeq ($(CONFIG_EXT_CLK), y)
EXTRA_CFLAGS += -DCONFIG_EXT_CLK
endif

ifeq ($(CONFIG_FTP_PROTECT), y)
EXTRA_CFLAGS += -DCONFIG_FTP_PROTECT
endif

ifeq ($(CONFIG_ODM_ADAPTIVITY), y)
EXTRA_CFLAGS += -DCONFIG_ODM_ADAPTIVITY
endif

ifeq ($(CONFIG_MMC_PM_KEEP_POWER), y)
EXTRA_CFLAGS += -DCONFIG_MMC_PM_KEEP_POWER
endif

ifeq ($(CONFIG_RTL8188E), y)
ifeq ($(CONFIG_WOWLAN), y)
EXTRA_CFLAGS += -DCONFIG_WOWLAN
EXTRA_CFLAGS += -DCONFIG_MMC_PM_KEEP_POWER
endif
ifeq ($(CONFIG_GPIO_WAKEUP), y)
EXTRA_CFLAGS += -DCONFIG_GPIO_WAKEUP
endif
endif

ifeq ($(CONFIG_RTL8188E), y)
ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
EXTRA_CFLAGS += -DCONFIG_RF_GAIN_OFFSET
endif
endif

ifeq ($(CONFIG_PLATFORM_I386_PC), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH ?= $(SUBARCH)
CROSS_COMPILE ?=
KVER  := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/
INSTALL_PREFIX :=
endif

ifeq ($(CONFIG_PLATFORM_ACTIONS_ATM702X), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ANDROID -DCONFIG_PLATFORM_ACTIONS_ATM702X
#ARCH := arm
ARCH := $(R_ARCH)
#CROSS_COMPILE := arm-none-linux-gnueabi-
CROSS_COMPILE := $(R_CROSS_COMPILE)
KVER:= 3.4.0
#KSRC := ../../../../build/out/kernel
KSRC := $(KERNEL_BUILD_PATH)
MODULE_NAME :=wlan
endif

ifeq ($(CONFIG_PLATFORM_TI_AM3517), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ANDROID -DCONFIG_PLATFORM_SHUTTLE
CROSS_COMPILE := arm-eabi-
KSRC := $(shell pwd)/../../../Android/kernel
ARCH := arm
endif

ifeq ($(CONFIG_PLATFORM_MSTAR_TITANIA12), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_MSTAR -DCONFIG_PLATFORM_MSTAR_TITANIA12
ARCH:=mips
CROSS_COMPILE:= /usr/src/Mstar_kernel/mips-4.3/bin/mips-linux-gnu-
KVER:= 2.6.28.9
KSRC:= /usr/src/Mstar_kernel/2.6.28.9/
endif

ifeq ($(CONFIG_PLATFORM_MSTAR), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_MSTAR
ARCH:=arm
CROSS_COMPILE:= /usr/src/bin/arm-none-linux-gnueabi-
KVER:= 3.1.10
KSRC:= /usr/src/Mstar_kernel/3.1.10/
endif

ifeq ($(CONFIG_PLATFORM_ANDROID_X86), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH := $(SUBARCH)
CROSS_COMPILE := /media/DATA-2/android-x86/ics-x86_20120130/prebuilt/linux-x86/toolchain/i686-unknown-linux-gnu-4.2.1/bin/i686-unknown-linux-gnu-
KSRC := /media/DATA-2/android-x86/ics-x86_20120130/out/target/product/generic_x86/obj/kernel
MODULE_NAME :=wlan
endif

ifeq ($(CONFIG_PLATFORM_JB_X86), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_P2P_IPS
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH := $(SUBARCH)
CROSS_COMPILE := /home/android_sdk/android-x86_JB/prebuilts/gcc/linux-x86/x86/i686-linux-android-4.7/bin/i686-linux-android-
KSRC := /home/android_sdk/android-x86_JB/out/target/product/x86/obj/kernel/
MODULE_NAME :=wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_PXA2XX), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
ARCH := arm
CROSS_COMPILE := arm-none-linux-gnueabi-
KVER  := 2.6.34.1
KSRC ?= /usr/src/linux-2.6.34.1
endif

ifeq ($(CONFIG_PLATFORM_ARM_RPI), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_MINIMAL_MEMORY_USAGE
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
ARCH := arm
CROSS_COMPILE := arm-none-linux-gnueabihf-
KVER  := 4.1_$(ARCH)
KSRC := /home/mike/Kubits/linux
endif

ifeq ($(CONFIG_PLATFORM_ARM_S3C2K4), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
ARCH := arm
CROSS_COMPILE := arm-linux-
KVER  := 2.6.24.7_$(ARCH)
KSRC := /usr/src/kernels/linux-$(KVER)
endif

ifeq ($(CONFIG_PLATFORM_ARM_S3C6K4), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
ARCH := arm
CROSS_COMPILE := arm-none-linux-gnueabi-
KVER  := 2.6.34.1
KSRC ?= /usr/src/linux-2.6.34.1
endif

ifeq ($(CONFIG_PLATFORM_RTD2880B), y)
EXTRA_CFLAGS += -DCONFIG_BIG_ENDIAN -DCONFIG_PLATFORM_RTD2880B
ARCH:=
CROSS_COMPILE:=
KVER:=
KSRC:=
endif

ifeq ($(CONFIG_PLATFORM_MIPS_RMI), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
ARCH:=mips
CROSS_COMPILE:=mipsisa32r2-uclibc-
KVER:=
KSRC:= /root/work/kernel_realtek
endif

ifeq ($(CONFIG_PLATFORM_MIPS_PLM), y)
EXTRA_CFLAGS += -DCONFIG_BIG_ENDIAN
ARCH:=mips
CROSS_COMPILE:=mipsisa32r2-uclibc-
KVER:=
KSRC:= /root/work/kernel_realtek
endif

ifeq ($(CONFIG_PLATFORM_MSTAR389), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_MSTAR389
ARCH:=mips
CROSS_COMPILE:= mips-linux-gnu-
KVER:= 2.6.28.10
KSRC:= /home/mstar/mstar_linux/2.6.28.9/
endif

ifeq ($(CONFIG_PLATFORM_MIPS_AR9132), y)
EXTRA_CFLAGS += -DCONFIG_BIG_ENDIAN
ARCH := mips
CROSS_COMPILE := mips-openwrt-linux-
KSRC := /home/alex/test_openwrt/tmp/linux-2.6.30.9
endif

ifeq ($(CONFIG_PLATFORM_DMP_PHILIPS), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DRTK_DMP_PLATFORM
ARCH := mips
#CROSS_COMPILE:=/usr/local/msdk-4.3.6-mips-EL-2.6.12.6-0.9.30.3/bin/mipsel-linux-
CROSS_COMPILE:=/usr/local/toolchain_mipsel/bin/mipsel-linux-
KSRC ?=/usr/local/Jupiter/linux-2.6.12
endif

ifeq ($(CONFIG_PLATFORM_RTK_DMP), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DRTK_DMP_PLATFORM
ARCH:=mips
CROSS_COMPILE:=mipsel-linux-
KVER:=
KSRC ?= /usr/src/DMP_Kernel/jupiter/linux-2.6.12
endif

ifeq ($(CONFIG_PLATFORM_MT53XX), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_MT53XX
ARCH:= arm
CROSS_COMPILE:= arm11_mtk_le-
KVER:= 2.6.27
KSRC?= /proj/mtk00802/BD_Compare/BDP/Dev/BDP_V301/BDP_Linux/linux-2.6.27
endif

ifeq ($(CONFIG_PLATFORM_ARM_MX51_241H), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_WISTRON_PLATFORM
ARCH := arm
CROSS_COMPILE := /opt/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-linux-gnueabi/bin/arm-none-linux-gnueabi-
KVER  := 2.6.31
KSRC ?= /lib/modules/2.6.31-770-g0e46b52/source
endif

ifeq ($(CONFIG_PLATFORM_ACTIONS_ATJ227X), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ACTIONS_ATJ227X
ARCH := mips
CROSS_COMPILE := /home/cnsd4/project/actions/tools-2.6.27/bin/mipsel-linux-gnu-
KVER  := 2.6.27
KSRC := /home/cnsd4/project/actions/linux-2.6.27.28
endif

ifeq ($(CONFIG_PLATFORM_TI_DM365), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_TI_DM365
ARCH := arm
CROSS_COMPILE := /home/cnsd4/Appro/mv_pro_5.0/montavista/pro/devkit/arm/v5t_le/bin/arm_v5t_le-
KVER  := 2.6.18
KSRC := /home/cnsd4/Appro/mv_pro_5.0/montavista/pro/devkit/lsp/ti-davinci/linux-dm365
endif

ifeq ($(CONFIG_PLATFORM_TEGRA3_CARDHU), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DRTW_ENABLE_WIFI_CONTROL_FUNC
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_P2P_IPS
ARCH := arm
CROSS_COMPILE := /home/android_sdk/nvidia/tegra-16r3-partner-android-4.1_20120723/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
KSRC := /home/android_sdk/nvidia/tegra-16r3-partner-android-4.1_20120723/out/target/product/cardhu/obj/KERNEL
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_TEGRA4_DALMORE), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DRTW_ENABLE_WIFI_CONTROL_FUNC
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_P2P_IPS
ARCH := arm
CROSS_COMPILE := /home/android_sdk/nvidia/tegra-17r9-partner-android-4.2-dalmore_20130131/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
KSRC := /home/android_sdk/nvidia/tegra-17r9-partner-android-4.2-dalmore_20130131/out/target/product/dalmore/obj/KERNEL
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_TCC8900), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
ARCH := arm
CROSS_COMPILE := /home/android_sdk/Telechips/SDK_2304_20110613/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
KSRC := /home/android_sdk/Telechips/SDK_2304_20110613/kernel
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_TCC8920), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
ARCH := arm
CROSS_COMPILE := /home/android_sdk/Telechips/v12.06_r1-tcc-android-4.0.4/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
KSRC := /home/android_sdk/Telechips/v12.06_r1-tcc-android-4.0.4/kernel
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_TCC8920_JB42), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_P2P_IPS
ARCH := arm
CROSS_COMPILE := /home/android_sdk/Telechips/v13.03_r1-tcc-android-4.2.2_ds_patched/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
KSRC := /home/android_sdk/Telechips/v13.03_r1-tcc-android-4.2.2_ds_patched/kernel
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_RK2818), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ANDROID -DCONFIG_PLATFORM_ROCKCHIPS -DCONFIG_MINIMAL_MEMORY_USAGE
ifeq ($(CONFIG_SDIO_HCI), y)
EXTRA_CFLAGS += -DCONFIG_DETECT_CPWM_BY_POLLING -DCONFIG_DETECT_C2H_BY_POLLING
endif
ARCH := arm
CROSS_COMPILE := /usr/src/release_fae_version/toolchain/arm-eabi-4.4.0/bin/arm-eabi-
KSRC := /usr/src/release_fae_version/kernel25_A7_281x
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_URBETTER), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN #-DCONFIG_MINIMAL_MEMORY_USAGE
ARCH := arm
CROSS_COMPILE := /media/DATA-1/urbetter/arm-2009q3/bin/arm-none-linux-gnueabi-
KSRC := /media/DATA-1/urbetter/ics-urbetter/kernel
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_ARM_TI_PANDA), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN #-DCONFIG_MINIMAL_MEMORY_USAGE
ARCH := arm
#CROSS_COMPILE := /media/DATA-1/aosp/ics-aosp_20111227/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
#KSRC := /media/DATA-1/aosp/android-omap-panda-3.0_20120104
CROSS_COMPILE := /media/DATA-1/android-4.0/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
KSRC := /media/DATA-1/android-4.0/panda_kernel/omap
MODULE_NAME := wlan
endif

ifeq ($(CONFIG_PLATFORM_MIPS_JZ4760), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_MINIMAL_MEMORY_USAGE
ARCH ?= mips
CROSS_COMPILE ?= /mnt/sdb5/Ingenic/Umido/mips-4.3/bin/mips-linux-gnu-
KSRC ?= /mnt/sdb5/Ingenic/Umido/kernel
endif

ifeq ($(CONFIG_PLATFORM_SZEBOOK), y)
EXTRA_CFLAGS += -DCONFIG_BIG_ENDIAN
ARCH:=arm
CROSS_COMPILE:=/opt/crosstool2/bin/armeb-unknown-linux-gnueabi- 
KVER:= 2.6.31.6
KSRC:= ../code/linux-2.6.31.6-2020/
endif

#Add setting for MN10300
ifeq ($(CONFIG_PLATFORM_MN10300), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_MN10300
ARCH := mn10300
CROSS_COMPILE := mn10300-linux-
KVER := 2.6.32.2
KSRC := /home/winuser/work/Plat_sLD2T_V3010/usr/src/linux-2.6.32.2
INSTALL_PREFIX :=
endif

ifeq ($(CONFIG_PLATFORM_ARM_SUNxI), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ARM_SUNxI
ifeq ($(CONFIG_USB_HCI), y)
EXTRA_CFLAGS += -DCONFIG_USE_USB_BUFFER_ALLOC_TX
endif
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DDCONFIG_P2P_IPS
# default setting for A10-EVB mmc0
ifeq ($(CONFIG_SDIO_HCI), y)
#EXTRA_CFLAGS += -DCONFIG_WITS_EVB_V13
endif
ARCH := arm
#CROSS_COMPILE := arm-none-linux-gnueabi-
CROSS_COMPILE=/home/android_sdk/Allwinner/a10/android-jb42/lichee-jb42/buildroot/output/external-toolchain/bin/arm-none-linux-gnueabi-
KVER  := 3.0.8
#KSRC:= ../lichee/linux-3.0/
KSRC=/home/android_sdk/Allwinner/a10/android-jb42/lichee-jb42/linux-3.0
endif

ifeq ($(CONFIG_PLATFORM_ARM_SUN6I), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_PLATFORM_ARM_SUN6I
ifeq ($(CONFIG_USB_HCI), y)
EXTRA_CFLAGS += -DCONFIG_USE_USB_BUFFER_ALLOC_TX
endif
# default setting for A31-EVB mmc0
ifeq ($(CONFIG_SDIO_HCI), y)
EXTRA_CFLAGS += -DCONFIG_A31_EVB
endif

EXTRA_CFLAGS += -DCONFIG_TRAFFIC_PROTECT
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_P2P_IPS -DCONFIG_QOS_OPTIMIZATION
ARCH := arm
CROSS_COMPILE := /home/android_sdk/Allwinner/a31/android-jb42/lichee/buildroot/output/external-toolchain/bin/arm-linux-gnueabi-
KVER  := 3.3.0
#KSRC:= ../lichee/linux-3.3/
KSRC :=/home/android_sdk/Allwinner/a31/android-jb42/lichee/linux-3.3
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME := 8188eu_sw
endif
endif

ifeq ($(CONFIG_PLATFORM_ARM_SUN7I), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
EXTRA_CFLAGS += -DCONFIG_PLATFORM_ARM_SUN7I
ifeq ($(CONFIG_USB_HCI), y)
EXTRA_CFLAGS += -DCONFIG_USE_USB_BUFFER_ALLOC_TX
endif
EXTRA_CFLAGS += -DCONFIG_TRAFFIC_PROTECT
# default setting for Android 4.1, 4.2
EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE
EXTRA_CFLAGS += -DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT
EXTRA_CFLAGS += -DCONFIG_P2P_IPS -DCONFIG_QOS_OPTIMIZATION
ARCH := arm
# Cross compile setting for Android 4.2 SDK
#CROSS_COMPILE := /home/android_sdk/Allwinner/a20/sugar/lichee/out/android/common/buildroot/external-toolchain/bin/arm-linux-gnueabi-
#KVER  := 3.3.0
#KSRC :=/home/android_sdk/Allwinner/a20/sugar/lichee/linux-3.3
# Cross compile setting for Android 4.3 SDK
CROSS_COMPILE := /home/android_sdk/Allwinner/a20/android-jb43/lichee/out/android/common/buildroot/external-toolchain/bin/arm-linux-gnueabi-
KVER  := 3.4.39
KSRC :=/home/android_sdk/Allwinner/a20/android-jb43/lichee/linux-3.4
endif


ifeq ($(CONFIG_PLATFORM_ACTIONS_ATV5201), y)
EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN -DCONFIG_PLATFORM_ACTIONS_ATV5201
ARCH := mips
CROSS_COMPILE := mipsel-linux-gnu-
KVER  := $(KERNEL_VER)
KSRC:= $(CFGDIR)/../../kernel/linux-$(KERNEL_VER)
endif

ifneq ($(USER_MODULE_NAME),)
MODULE_NAME := $(USER_MODULE_NAME)
endif

ifneq ($(KERNELRELEASE),)

rtk_core :=	core/rtw_cmd.o \
		core/rtw_security.o \
		core/rtw_debug.o \
		core/rtw_io.o \
		core/rtw_ioctl_query.o \
		core/rtw_ioctl_set.o \
		core/rtw_ieee80211.o \
		core/rtw_mlme.o \
		core/rtw_mlme_ext.o \
		core/rtw_wlan_util.o \
		core/rtw_pwrctrl.o \
		core/rtw_rf.o \
		core/rtw_recv.o \
		core/rtw_sta_mgt.o \
		core/rtw_ap.o \
		core/rtw_xmit.o	\
		core/rtw_p2p.o \
		core/rtw_tdls.o \
		core/rtw_br_ext.o \
		core/rtw_iol.o \
		core/rtw_led.o \
		core/rtw_sreset.o \
		core/rtw_odm.o

$(MODULE_NAME)-y += $(rtk_core)

$(MODULE_NAME)-$(CONFIG_INTEL_WIDI) += core/rtw_intel_widi.o

$(MODULE_NAME)-$(CONFIG_WAPI_SUPPORT) += core/rtw_wapi.o	\
					core/rtw_wapi_sms4.o

$(MODULE_NAME)-y += core/efuse/rtw_efuse.o

$(MODULE_NAME)-y += $(_HAL_INTFS_FILES)

$(MODULE_NAME)-y += $(_OS_INTFS_FILES)

$(MODULE_NAME)-$(CONFIG_MP_INCLUDED) += core/rtw_mp.o \
					core/rtw_mp_ioctl.o
ifeq ($(CONFIG_RTL8723A), y)

$(MODULE_NAME)-$(CONFIG_MP_INCLUDED)+= core/rtw_bt_mp.o
endif

obj-$(CONFIG_RTL8188EU) := $(MODULE_NAME).o

else

export CONFIG_RTL8188EU = m

all: modules

modules:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(shell pwd)  modules

strip:
	$(CROSS_COMPILE)strip $(MODULE_NAME).ko --strip-unneeded

install:
	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)
	/sbin/depmod -a ${KVER}

uninstall:
	rm -f $(MODDESTDIR)/$(MODULE_NAME).ko
	/sbin/depmod -a ${KVER}

config_r:
	@echo "make config"
	/bin/bash script/Configure script/config.in

.PHONY: modules clean clean_odm-8192c

clean_odm-8192c:
	cd hal/OUTSRC/rtl8192c ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko

clean: $(clean_more)
	rm -fr *.mod.c *.mod *.o .*.cmd *.ko *~
	rm -fr .tmp_versions
	rm -fr Module.symvers ; rm -fr Module.markers ; rm -fr modules.order
	cd core/efuse ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd core ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd hal/$(RTL871X)/$(HCI_NAME) ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd hal/$(RTL871X) ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd hal/OUTSRC/$(RTL871X) ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko 
	cd hal/OUTSRC/ ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko 
	cd hal ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd os_dep/linux ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd os_dep ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
endif

