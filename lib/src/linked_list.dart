// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class _LinkedListNode<E> {
  E value;
  _LinkedListNode<E>? next;

  _LinkedListNode(this.value);
}

class LinkedList<E> {
  _LinkedListNode<E>? _head;
  _LinkedListNode<E>? _tail;
  int _length = 0;

  void add(E value) {
    var newNode = _LinkedListNode(value);
    if (_tail == null) {
      _head = _tail = newNode;
    } else {
      _tail!.next = newNode;
      _tail = newNode;
    }
    _length++;
  }

  bool remove(E value) {
    if (_head == null) {
      return false;
    }

    if (_head!.value == value) {
      _head = _head!.next;
      if (_head == null) {
        _tail = null;
      }
      _length--;
      return true;
    }

    var currentNode = _head;
    while (currentNode!.next != null && currentNode.next!.value != value) {
      currentNode = currentNode.next;
    }

    if (currentNode.next == null) {
      return false;
    }

    if (currentNode.next == _tail) {
      _tail = currentNode;
    }

    currentNode.next = currentNode.next!.next;
    _length--;
    return true;
  }

  E? operator [](int index) {
    if (index < 0 || index >= _length) {
      return null;
    }

    var currentNode = _head;
    for (var i = 0; i < index; i++) {
      currentNode = currentNode!.next;
    }

    return currentNode!.value;
  }

  void operator []=(int index, E value) {
    if (index < 0 || index >= _length) {
      throw RangeError.range(index, 0, _length - 1, 'Index out of range');
    }

    var currentNode = _head;
    for (var i = 0; i < index; i++) {
      currentNode = currentNode!.next;
    }

    currentNode!.value = value;
  }

  int get length => _length;

  bool get isEmpty => _length == 0;

  bool get isNotEmpty => _length > 0;

  void clear() {
    _head = _tail = null;
    _length = 0;
  }

  Iterable<E> get iterable {
    return Iterable.generate(_length, (index) => this[index]!);
  }

  List<E> toList() {
    var list = List<E>.generate(_length, (index) => this[index]!);
    return list;
  }
}