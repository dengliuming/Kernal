################################################################################
#
# 100ask stm32mp157 board  usb ip config  weidongshan@qq.com
#
################################################################################

STM32MP1_USBIP_VERSION = b3be6e29bc543561afb9551a088594d500fd194f
STM32MP1_USBIP_SITE = https://gitee.com/weidongshan/RootfsPackages.git
STM32MP1_USBIP_SITE_METHOD = git
STM32MP1_USBIP_LICENSE = GPL-3.0

define STM32MP1_USBIP_BUILD_CMDS
	cd $(@D);
endef

define STM32MP1_USBIP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/hwdata/;
	mkdir -p $(TARGET_DIR)/etc/modprobe.d/;
	cp -rdpf $(@D)/usbip/libusbip.so* $(TARGET_DIR)/usr/lib/;
	cp -rdpf $(@D)/usbip/libwrap.so* $(TARGET_DIR)/lib/;
	$(INSTALL) -D -m 0755 $(@D)/usbip/stm32mp-usbip-bind-unbind.sh \
		$(TARGET_DIR)/usr/sbin/stm32mp-usbip-bind-unbind.sh
	$(INSTALL) -D -m 0755 $(@D)/usbip/usb.ids \
		$(TARGET_DIR)/usr/share/hwdata/usb.ids
	$(INSTALL) -D -m 0755 $(@D)/usbip/99-usb-usbip.rules \
		$(TARGET_DIR)/etc/udev/rules.d/99-usb-usbip.rules
	$(INSTALL) -D -m 0755 $(@D)/usbip/usbip.conf \
		$(TARGET_DIR)/etc/modprobe.d/usbip.conf
	$(INSTALL) -D -m 0755 $(@D)/usbip/sbin/usbip \
		$(TARGET_DIR)/usr/sbin/usbip
	$(INSTALL) -D -m 0755 $(@D)/usbip/sbin/usbipd \
		$(TARGET_DIR)/usr/sbin/usbipd
endef
		  			 		  						  					  				 	   		  	  	 	  
define STM32MP1_USBIP_INSTALL_INIT_SYSV

endef

define STM32MP1_USBIP_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/usbip/usbip.service \
		$(TARGET_DIR)/usr/lib/systemd/system/usbip.service
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))
