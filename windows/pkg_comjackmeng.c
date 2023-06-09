/**
 * Copyright 2023 Jack Meng. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */


#include <windows.h>

__declspec(dllexport) int getProcessId()
{
    return GetCurrentProcessId();
}