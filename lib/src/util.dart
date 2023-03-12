// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


extension StringPrintf on String {
  String printf(List<dynamic> args) {
    int argIndex = 0;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      if (this[i] == '%') {
        i++;

        if (i >= length) {
          throw Exception('Invalid format string');
        }

        String formatSpecifier = this[i];
        i++;

        if (i < length && this[i] == formatSpecifier) {
          formatSpecifier += this[i];
          i++;
        }

        if (argIndex >= args.length) {
          throw Exception('Too few arguments for format string');
        }

        dynamic arg = args[argIndex];

        if (formatSpecifier == '%') {
          buffer.write('%');
        } else if (formatSpecifier == 'd' || formatSpecifier == 'i') {
          buffer.write(arg.toStringAsFixed(0));
        } else if (formatSpecifier == 'f') {
          buffer.write(arg.toStringAsFixed(6));
        } else if (formatSpecifier == 's') {
          buffer.write(arg.toString());
        } else {
          throw Exception('Invalid format specifier: $formatSpecifier');
        }

        argIndex++;
      } else {
        buffer.write(this[i]);
      }
    }

    if (argIndex < args.length) {
      throw Exception('Too many arguments for format string');
    }

    return buffer.toString();
  }
}
