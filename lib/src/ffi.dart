import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

// Platform detection helper for HarmonyOS
bool get _isHarmonyOS {
  try {
    // HarmonyOS identification - check platform environment and version info
    // HarmonyOS Next uses 'ohos' as the platform identifier
    if (Platform.operatingSystem == 'ohos') {
      return true;
    }
    
    // Alternative detection methods for HarmonyOS
    final environment = Platform.environment;
    if (environment.containsKey('OHOS_SDK_HOME') || 
        environment.containsKey('HARMONY_HOME') ||
        environment.containsKey('OHOS_NDK_HOME')) {
      return true;
    }
    
    // Check platform version for HarmonyOS identifiers
    final version = Platform.version.toLowerCase();
    if (version.contains('harmonyos') || 
        version.contains('ohos') ||
        version.contains('harmony')) {
      return true;
    }
    
    return false;
  } catch (e) {
    // If platform detection fails, assume not HarmonyOS
    return false;
  }
}

final _nativeLib = Platform.isAndroid || _isHarmonyOS
    ? DynamicLibrary.open('libstockfish.so')
    : DynamicLibrary.process();

final int Function() nativeInit = _nativeLib
    .lookup<NativeFunction<Int32 Function()>>('stockfish_init')
    .asFunction();

final int Function() nativeMain = _nativeLib
    .lookup<NativeFunction<Int32 Function()>>('stockfish_main')
    .asFunction();

final int Function(Pointer<Utf8>) nativeStdinWrite = _nativeLib
    .lookup<NativeFunction<IntPtr Function(Pointer<Utf8>)>>(
        'stockfish_stdin_write')
    .asFunction();

final Pointer<Utf8> Function() nativeStdoutRead = _nativeLib
    .lookup<NativeFunction<Pointer<Utf8> Function()>>('stockfish_stdout_read')
    .asFunction();
