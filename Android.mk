# Copyright (c) 2015 μg Project Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := afhDownloader
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := afhDownloader

afhdownloader_root  := $(LOCAL_PATH)
afhdownloader_dir   := app
afhdownloader_out   := $(OUT_DIR)/target/common/obj/APPS/$(LOCAL_MODULE)_intermediates
afhdownloader_build := $(afhdownloader_root)/$(afhdownloader_dir)/build
afhdownloader_apk   := build/outputs/apk/app-release-unsigned.apk

$(afhdownloader_root)/$(afhdownloader_dir)/$(afhdownloader_apk):
	rm -Rf $(afhdownloader_build)
	mkdir -p $(afhdownloader_out)
	ln -s $(afhdownloader_out) $(afhdownloader_build)
	echo "sdk.dir=$(ANDROID_HOME)" > $(afhdownloader_root)/local.properties
	cd $(afhdownloader_root) && git submodule update --recursive --init
	cd $(afhdownloader_root)/$(afhdownloader_dir) && JAVA_TOOL_OPTIONS="$(JAVA_TOOL_OPTIONS) -Dfile.encoding=UTF8" ../gradlew assembleRelease

LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := $(afhdownloader_dir)/$(afhdownloader_apk)
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/app

include $(BUILD_PREBUILT)
