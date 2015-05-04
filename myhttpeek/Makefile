THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 2222
ARCHS = armv7 armv7s arm64
TARGET = iphone:latest:7.1

include theos/makefiles/common.mk

APPLICATION_NAME = myhttpeek
myhttpeek_FILES = main.m myhttpeekApplication.mm AppDB.m GTMNSString+HTML.m NSString+HTML.m MyAdditions.m RootViewController.mm
myhttpeek_FRAMEWORKS =Foundation CoreGraphics UIKit

include $(THEOS_MAKE_PATH)/application.mk
after-stage::
	$(ECHO_NOTHING)chmod +s $(THEOS_STAGING_DIR)/Applications/myhttpeek.app/myhttpeek$(ECHO_END)