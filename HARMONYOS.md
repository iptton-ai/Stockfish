# HarmonyOS Next Support

This Flutter Stockfish plugin supports HarmonyOS Next (API Level 10+) through FFI bindings.

## Prerequisites

- HarmonyOS Next SDK (API Level 10+)
- DevEco Studio 5.0+  
- Native Development Kit (NDK) for HarmonyOS
- Flutter 3.0+ with HarmonyOS support

## Setup

1. **Install HarmonyOS Next SDK**:
   ```bash
   # Set environment variables
   export OHOS_SDK_HOME=/path/to/harmonyos-sdk
   export PATH=$PATH:$OHOS_SDK_HOME/toolchains
   ```

2. **Add to pubspec.yaml**:
   ```yaml
   dependencies:
     stockfish: ^1.8.0
   ```

3. **Import and use**:
   ```dart
   import 'package:stockfish/stockfish.dart';
   
   final stockfish = Stockfish();
   
   // Wait for initialization
   stockfish.state.addListener(() {
     if (stockfish.state.value == StockfishState.ready) {
       // Engine is ready to use
       stockfish.stdin = 'uci';
     }
   });
   ```

## Build Configuration

The plugin automatically detects HarmonyOS Next platform and uses:

- **Native Library**: `libstockfish.so` (built with CMake)
- **Architecture Support**: ARM64, ARM32
- **Platform Detection**: Automatic via environment variables and platform checks

## Architecture Support

| Architecture | Support | Optimization |
|--------------|---------|--------------|
| ARM64-v8a    | ✅      | NEON, POPCNT |
| ARMv7-a      | ✅      | Standard     |
| x86_64       | ✅      | POPCNT       |

## Troubleshooting

### Library Loading Issues
If you encounter `DynamicLibrary.open()` errors:

1. Verify HarmonyOS NDK is properly installed
2. Check that `libstockfish.so` is built correctly
3. Ensure your app has native library permissions

### Platform Detection Issues
The plugin detects HarmonyOS through multiple methods:
- `Platform.operatingSystem == 'ohos'` 
- Environment variables (`OHOS_SDK_HOME`, `HARMONY_HOME`)
- Version string analysis

### Performance Optimization
For best performance on HarmonyOS:
- Use ARM64 architecture when possible
- Enable compiler optimizations (handled automatically)
- Consider NEON SIMD instructions for chess calculations

## Example Project

See the `example/` directory for a complete working implementation that supports Android, iOS, and HarmonyOS Next.

## Building from Source

To build the native library for HarmonyOS:

```bash
cd ohos/src/main/cpp
cmake -DCMAKE_TOOLCHAIN_FILE=$OHOS_NDK_HOME/toolchains/ohos.toolchain.cmake \
      -DOHOS_ARCH=arm64-v8a \
      -DCMAKE_BUILD_TYPE=Release \
      .
make -j$(nproc)
```

## License

This HarmonyOS implementation maintains the same GPL v3 license as the main Stockfish engine.