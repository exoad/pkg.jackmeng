// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class MinHeap<T extends Comparable<T>> {
  late List<T> _heap;
  late int _size;

  MinHeap() {
    _heap = <T>[];
    _size = 0;
  }

  MinHeap.fromList(List<T> list) {
    _heap = List.from(list);
    _size = list.length;

    for (int i = (_size ~/ 2) - 1; i >= 0; i--) {
      _siftDown(i);
    }
  }

  void insert(T element) {
    if (_size == _heap.length) {
      throw Exception('Heap is full');
    }

    _heap[_size] = element;
    _size++;

    _siftUp(_size - 1);
  }

  T extractMin() {
    if (_size == 0) {
      throw Exception('Heap is empty');
    }

    T min = _heap[0];
    _heap[0] = _heap[_size - 1];
    _size--;

    _siftDown(0);

    return min;
  }

  void _siftUp(int index) {
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;

      if (_heap[parentIndex].compareTo(_heap[index]) <= 0) {
        break;
      }

      T temp = _heap[index];
      _heap[index] = _heap[parentIndex];
      _heap[parentIndex] = temp;

      index = parentIndex;
    }
  }

  void _siftDown(int index) {
    while (true) {
      int leftChildIndex = 2 * index + 1;
      int rightChildIndex = 2 * index + 2;
      int smallestChildIndex = index;

      if (leftChildIndex < _size &&
          _heap[leftChildIndex].compareTo(_heap[smallestChildIndex]) < 0) {
        smallestChildIndex = leftChildIndex;
      }

      if (rightChildIndex < _size &&
          _heap[rightChildIndex].compareTo(_heap[smallestChildIndex]) < 0) {
        smallestChildIndex = rightChildIndex;
      }

      if (smallestChildIndex == index) {
        break;
      }

      T temp = _heap[index];
      _heap[index] = _heap[smallestChildIndex];
      _heap[smallestChildIndex] = temp;

      index = smallestChildIndex;
    }
  }
}
