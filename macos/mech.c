/**
 * Copyright 2023 Jack Meng. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef void* (*CreateShaderParserFunc)();
typedef void (*ReleaseShaderParserFunc)(void*);
typedef void* (*ParseShaderFragmentFunc)(void*, const char*, char**);
typedef void (*ReleaseShaderFunctionFunc)(void*);

int main() {
  void* handle = dlopen("./libshader_parser.dylib", RTLD_NOW);
  if (!handle) {
    fprintf(stderr, "Error loading library: %s\n", dlerror());
    return EXIT_FAILURE;
  }

  CreateShaderParserFunc createParser = dlsym(handle, "create_shader_parser");
  ReleaseShaderParserFunc releaseParser =
      dlsym(handle, "release_shader_parser");
  ParseShaderFragmentFunc parseFragment =
      dlsym(handle, "parse_shader_fragment");
  ReleaseShaderFunctionFunc releaseFunction =
      dlsym(handle, "release_shader_function");

  if (!createParser || !releaseParser || !parseFragment || !releaseFunction) {
    fprintf(stderr, "Error loading symbols: %s\n", dlerror());
    dlclose(handle);
    return EXIT_FAILURE;
  }

  void* parser = createParser();

  const char* source =
      "#include <metal_stdlib>\nusing namespace metal;\n\nfragment float4 "
      "shader_fragment() {\n    return float4(1.0);\n}";
  char* error = NULL;

  void* function = parseFragment(parser, source, &error);

  if (function) {
    printf("Shader function successfully parsed.\n");
    releaseFunction(function);
  } else {
    fprintf(stderr, "Error parsing shader: %s\n", error);
    free(error);
  }

  releaseParser(parser);
  dlclose(handle);
  return EXIT_SUCCESS;
}