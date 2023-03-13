// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

String dynlibExtension() {
  return Platform.isLinux
      ? "so"
      : Platform.isMacOS
          ? "dylib"
          : Platform.isWindows
              ? "dll"
              : Platform.isAndroid
                  ? "dex"
                  : "so";
}

Future<String> executeCommand(String command, List<String> arguments) async {
  final result = await Process.run(command, arguments);

  if (result.exitCode == 0) {
    final output = result.stdout as String;
    return output;
  } else {
    final error = result.stderr as String;
    throw Exception('Command failed with exit code ${result.exitCode}: $error');
  }
}

void execOnlyDesktop(void Function() runnable) {
  if (Platform.isFuchsia ||
      Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isWindows) runnable();
}

void execOnlyMobile(void Function() runnable) {
  if (Platform.isIOS || Platform.isAndroid) runnable();
}
