/*
 *
 *    Copyright (c) 2020 Project CHIP Authors
 *    Copyright (c) 2019 Google LLC.
 *    All rights reserved.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

#include "AppTask.h"

#include <logging/log.h>

#include <BuildConfig.h>
#include <platform/CHIPDeviceLayer.h>

LOG_MODULE_REGISTER(app);

using namespace ::chip;
using namespace ::chip::Inet;
using namespace ::chip::DeviceLayer;

int main()
{
    int ret = 0;

    k_thread_priority_set(k_current_get(), K_PRIO_COOP(CONFIG_NUM_COOP_PRIORITIES - 1));

    LOG_INF("Init CHIP stack");
    ret = PlatformMgr().InitChipStack();
    if (ret != CHIP_NO_ERROR)
    {
        LOG_ERR("PlatformMgr().InitChipStack() failed");
        goto exit;
    }

    LOG_INF("Starting CHIP task");
    ret = PlatformMgr().StartEventLoopTask();
    if (ret != CHIP_NO_ERROR)
    {
        LOG_ERR("PlatformMgr().StartEventLoopTask() failed");
        goto exit;
    }

#if CHIP_DEVICE_CONFIG_ENABLE_THREAD
    LOG_INF("Init Thread stack");
    ret = ThreadStackMgr().InitThreadStack();
    if (ret != CHIP_NO_ERROR)
    {
        LOG_ERR("ThreadStackMgr().InitThreadStack() failed");
        goto exit;
    }
#endif

    ret = GetAppTask().StartApp();

exit:
    LOG_ERR("Exited with code %d", ret);
    return ret;
}
