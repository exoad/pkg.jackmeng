// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class Monad<T> {
  final T val;

  const Monad(this.val);

  Monad<U> bind<U>(Monad<U> Function(T) f) => f(val);

  static Monad<T> of<T>(T value) => Monad(value);
}

Function(T) memoize<T, U>(U Function(T) f) {
  final cache = <T, U>{};
  return (x) => cache.putIfAbsent(x, () => f(x));
}

T identity<T>(T value) => value;

R Function(T) compose<T, U, R>(R Function(U) f, U Function(T) g) =>
    (x) => f(g(x));
R Function(T, U) flip<T, U, R>(R Function(U, T) f) => (x, y) => f(y, x);

R Function(U) partial<T, U, R>(R Function(T, U) f, T arg) => (x) => f(arg, x);
