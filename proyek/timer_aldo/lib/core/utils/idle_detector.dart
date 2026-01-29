import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

class IdleDetector {
  Timer? _idleCheckTimer;
  int _idleThresholdSeconds;
  final Function(bool)? _onIdleStateChanged;
  bool _isCurrentlyIdle = false;
  
  IdleDetector({
    required int idleThresholdSeconds,
    Function(bool)? onIdleStateChanged,
  })  : _idleThresholdSeconds = idleThresholdSeconds,
        _onIdleStateChanged = onIdleStateChanged;
  
  // Windows API structures and functions
  final DynamicLibrary _user32 = DynamicLibrary.open('user32.dll');
  
  late final int Function() _getLastInputInfo = _user32
      .lookup<NativeFunction<Uint32 Function()>>('GetTickCount')
      .asFunction();
  
  late final int Function(Pointer<LASTINPUTINFO>) _getLastInputInfoNative = _user32
      .lookup<NativeFunction<Int32 Function(Pointer<LASTINPUTINFO>)>>('GetLastInputInfo')
      .asFunction();
  
  void start() {
    _idleCheckTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkIdleState(),
    );
  }
  
  void stop() {
    _idleCheckTimer?.cancel();
    _idleCheckTimer = null;
  }
  
  void updateThreshold(int seconds) {
    _idleThresholdSeconds = seconds;
  }
  
  void _checkIdleState() {
    final idleSeconds = getIdleTime();
    final isIdle = idleSeconds >= _idleThresholdSeconds;
    
    if (isIdle != _isCurrentlyIdle) {
      _isCurrentlyIdle = isIdle;
      _onIdleStateChanged?.call(isIdle);
    }
  }
  
  int getIdleTime() {
    try {
      final lastInputInfo = calloc<LASTINPUTINFO>();
      lastInputInfo.ref.cbSize = sizeOf<LASTINPUTINFO>();
      
      final result = _getLastInputInfoNative(lastInputInfo);
      
      if (result != 0) {
        final currentTickCount = _getLastInputInfo();
        final lastInputTickCount = lastInputInfo.ref.dwTime;
        final idleMilliseconds = currentTickCount - lastInputTickCount;
        
        calloc.free(lastInputInfo);
        return idleMilliseconds ~/ 1000;
      }
      
      calloc.free(lastInputInfo);
      return 0;
    } catch (e) {
      return 0;
    }
  }
  
  bool get isIdle => _isCurrentlyIdle;
  
  void dispose() {
    stop();
  }
}

// Windows LASTINPUTINFO structure
final class LASTINPUTINFO extends Struct {
  @Uint32()
  external int cbSize;
  
  @Uint32()
  external int dwTime;
}
