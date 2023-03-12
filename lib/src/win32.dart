// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;
import 'dart:io' show Platform;

typedef GetProcessIdNative = ffi.Int32 Function();
typedef GetProcessId = int Function();

int getProcessIdPointer() {
  final dylib = Platform.isWindows
      ? ffi.DynamicLibrary.open('mylib.dll')
      : ffi.DynamicLibrary.open('mylib.so');

  final getProcessIdPointer =
      dylib.lookupFunction<GetProcessIdNative, GetProcessId>('getProcessId');

  return getProcessIdPointer();
}
