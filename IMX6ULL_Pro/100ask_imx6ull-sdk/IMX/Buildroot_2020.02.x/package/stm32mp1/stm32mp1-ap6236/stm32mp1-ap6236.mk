################################################################################
#
# ap6236 firmware weidongshan@qq.com
#
################################################################################
STM32MP1_AP6236_VERSION = 45a981bc2a9b6c21fd77a2704e7f593200a7828e
STM32MP1_AP6236_SITE = https://e.coding.net/lichang70/linux-fw-myir.git
STM32MP1_AP6236_SITE_METHOD = git
STM32MP1_AP6236_LICENSE = GPL-3.0
		  			 		  						  					  				 	   		  	  	 	  
define STM32MP1_AP6236_BUILD_CMDS
	cd $(@D);
endef
		  			 		  						  					  				 	   		  	  	 	  
define STM32MP1_AP6236_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware/brcm/;
	$(INSTALL) -D -m 0664 $(@D)/BCM4343B0.hcd \
		$(TARGET_DIR)/lib/firmware/brcm/BCM.hcd
	$(INSTALL) -D -m 0664 $(@D)/nvram_ap6236.txt \
		$(TARGET_DIR)/lib/firmware/nvram_ap6236.txt
	$(INSTALL) -D -m 0664 $(@D)/fw_bcm43436b0.bin \
		$(TARGET_DIR)/lib/firmware/fw_bcm43436b0.bin
	$(INSTALL) -D -m 0664 $(@D)/fw_bcm43436b0_apsta.bin \
		$(TARGET_DIR)/lib/firmware/fw_bcm43436b0_apsta.bin
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))