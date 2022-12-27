################################################################################
#
# 100ask stm32mp157 board  usb otg  weidongshan@qq.com
#
################################################################################
STM32MP1_USBOTG_VERSION = a4f1db230084e00c0adcc94f63519057f1b9b305
STM32MP1_USBOTG_SITE = https://gitee.com/weidongshan/RootfsPackages.git
STM32MP1_USBOTG_SITE_METHOD = git
STM32MP1_USBOTG_LICENSE = GPL-3.0

define STM32MP1_USBOTG_BUILD_CMDS
	cd $(@D);
endef
		  			 		  						  					  				 	   		  	  	 	  
define STM32MP1_USBOTG_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(@D)/usbotg/stm32_usbotg_eth_config.sh \
		$(TARGET_DIR)/etc/init.d/stm32_usbotg_eth_config.sh
endef

define STM32MP1_USBOTG_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0755 $(@D)/usbotg/stm32_usbotg_eth_config.sh \
		$(TARGET_DIR)/sbin/stm32_usbotg_eth_config.sh
	$(INSTALL) -D -m 644 $(@D)/usbotg/53-usb-otg.network \
		$(TARGET_DIR)/lib/systemd/network/53-usb-otg.network
	$(INSTALL) -D -m 644 $(@D)/usbotg/usbotg-config.service \
		$(TARGET_DIR)/lib/systemd/system/usbotg-config.service
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))
