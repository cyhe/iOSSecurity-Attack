export THEOS=/opt/theos
export THEOS_DEVICE_IP = 192.168.35.252
ARCHS = armv7 arm64
TARGET = iphone:8.1:8.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HHLYDemoiOSHookerTweak
HHLYDemoiOSHookerTweak_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 iostargetapphhly"
