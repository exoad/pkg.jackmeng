// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

typedef GetCpuUsageFunc = ffi.Int32 Function();
typedef GetCpuUsage = int Function();

int getCpuUsage() {
  final dylib = ffi.DynamicLibrary.open('/lib/libjackmeng.so');

  final getCpuUsage =
      dylib.lookupFunction<GetCpuUsageFunc, GetCpuUsage>('get_cpu_usage');

  return getCpuUsage();
}
