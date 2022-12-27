################################################################################
#
# 100ask stm32mp157 m4 dtbo files  weidongshan@qq.com
#
################################################################################
STM32MP1_DTBO_VERSION = d50d10f582d63f11d3bd83f95d9f3e573739dcf3
STM32MP1_DTBO_SITE = https://gitee.com/weidongshan/stm32mp157-m4.git
STM32MP1_DTBO_SITE_METHOD = git
STM32MP1_DTBO_LICENSE = GPL-3.0
		  			 		  						  					  				 	   		  	  	 	  
define STM32MP1_DTBO_BUILD_CMDS
	cd $(@D);
endef
		  			 		  						  					  				 	   		  	  	 	  
define STM32MP1_DTBO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/stm32mp157-m4;
	cp -rdvpf $(@D)/IP_ALLOC   $(TARGET_DIR)/usr/share/stm32mp157-m4/;
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))