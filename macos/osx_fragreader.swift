// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import MetalKit

class ShaderFragmentParser {
    private let device: MTLDevice

    init(device: MTLDevice) {
        self.device = device``
    }

    func parse(source: String) throws -> MTLFunction {
        let library = try device.makeLibrary(source: source, options: nil)
        guard let function = library.makeFunction(name: "shader_fragment") else {
            throw ShaderParsingError.functionNotFound
        }
        guard function.functionType == .fragment else {
            throw ShaderParsingError.incorrectFunctionType
        }
        return function
    }
}

enum ShaderParsingError: Error {
    case functionNotFound
    case incorrectFunctionType
}
