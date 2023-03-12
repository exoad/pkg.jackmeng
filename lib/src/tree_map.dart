// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class TreeMap<K extends Comparable<K>, V> {
  _Node<K, V>? _root;

  V? operator [](K key) {
    final node = _findNode(key);
    return node?.value;
  }

  void operator []=(K key, V value) {
    _root = _insert(_root, key, value);
  }

  void remove(K key) {
    _root = _delete(_root, key);
  }

  bool containsKey(K key) => _findNode(key) != null;

  Iterable<K> get keys sync* {
    if (_root != null) {
      final stack = [_root!];
      while (stack.isNotEmpty) {
        final node = stack.removeLast();
        yield node.key;
        if (node.right != null) stack.add(node.right!);
        if (node.left != null) stack.add(node.left!);
      }
    }
  }

  _Node<K, V>? _findNode(K key) {
    var node = _root;
    while (node != null) {
      final cmp = key.compareTo(node.key);
      if (cmp == 0) {
        return node;
      } else if (cmp < 0) {
        node = node.left;
      } else {
        node = node.right;
      }
    }
    return null;
  }

  _Node<K, V>? _insert(_Node<K, V>? node, K key, V value) {
    if (node == null) {
      return _Node(key, value);
    }
    final cmp = key.compareTo(node.key);
    if (cmp == 0) {
      node.value = value;
    } else if (cmp < 0) {
      node.left = _insert(node.left, key, value);
    } else {
      node.right = _insert(node.right, key, value);
    }
    return node;
  }

  _Node<K, V>? _delete(_Node<K, V>? node, K key) {
    if (node == null) {
      return null;
    }
    final cmp = key.compareTo(node.key);
    if (cmp == 0) {
      if (node.left == null) {
        return node.right;
      } else if (node.right == null) {
        return node.left;
      } else {
        var minNode = node.right!;
        while (minNode.left != null) {
          minNode = minNode.left!;
        }
        node.key = minNode.key;
        node.value = minNode.value;
        node.right = _delete(node.right, node.key);
      }
    } else if (cmp < 0) {
      node.left = _delete(node.left, key);
    } else {
      node.right = _delete(node.right, key);
    }
    return node;
  }
}

class _Node<K, V> {
  K key;
  V value;
  _Node<K, V>? left;
  _Node<K, V>? right;

  _Node(this.key, this.value);
}
