// Copyright 2023 Jack Meng. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import MetalKit
import Foundation

@_cdecl("create_shader_parser")
public func createShaderParser() -> UnsafeMutableRawPointer? {
    let device = MTLCreateSystemDefaultDevice()
    let parser = ShaderFragmentParser(device: device!)
    return Unmanaged.passRetained(parser).toOpaque()
}

@_cdecl("parse_shader_fragment")
public func parseShaderFragment(parserPtr: UnsafeMutableRawPointer?,
                                source: UnsafePointer<CChar>?,
                                error: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?) -> UnsafeMutableRawPointer? {
    let parser = Unmanaged<ShaderFragmentParser>.fromOpaque(parserPtr!).takeUnretainedValue()
    let sourceString = String(cString: source!)
    do {
        let function = try parser.parse(source: sourceString)
        return Unmanaged.passRetained(function).toOpaque()
    } catch let parsingError as ShaderParsingError {
        error?.pointee = strdup(parsingError.localizedDescription)
    } catch let error {
        error?.pointee = strdup(error.localizedDescription)
    }
    return nil
}

@_cdecl("release_shader_parser")
public func releaseShaderParser(parserPtr: UnsafeMutableRawPointer?) {
    Unmanaged<ShaderFragmentParser>.fromOpaque(parserPtr!).release()
}

@_cdecl("release_shader_function")
public func releaseShaderFunction(functionPtr: UnsafeMutableRawPointer?) {
    Unmanaged<MTLFunction>.fromOpaque(functionPtr!).release()
}