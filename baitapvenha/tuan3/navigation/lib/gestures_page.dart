import 'package:flutter/material.dart';

class GesturesPage extends StatefulWidget {
  const GesturesPage({super.key});

  @override
  State<GesturesPage> createState() => _GesturesPageState();
}

class _GesturesPageState extends State<GesturesPage> {
  String _gestureStatus = 'No gesture detected';
  double _scale = 1.0;
  double _rotation = 0.0;
  double _positionX = 0.0;
  double _positionY = 0.0;
  Color _boxColor = Colors.blue.withValues(alpha: 0.3);
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestures Page')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Basic Tap Gestures
            Text(
              '1. Basic Tap Gestures',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Thử tap, double tap, và long press vào box dưới đây:',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTapDown:
                  (details) => setState(
                    () =>
                        _gestureStatus = 'Tap Down at ${details.localPosition}',
                  ),
              onTapUp:
                  (details) => setState(
                    () => _gestureStatus = 'Tap Up at ${details.localPosition}',
                  ),
              onTap: () => setState(() => _gestureStatus = 'Tapped'),
              onTapCancel:
                  () => setState(() => _gestureStatus = 'Tap Cancelled'),
              onDoubleTap:
                  () => setState(() => _gestureStatus = 'Double Tapped'),
              onLongPress:
                  () => setState(() => _gestureStatus = 'Long Pressed'),
              onLongPressStart:
                  (details) =>
                      setState(() => _gestureStatus = 'Long Press Started'),
              onLongPressEnd:
                  (details) =>
                      setState(() => _gestureStatus = 'Long Press Ended'),
              child: Container(
                height: 100,
                color: _boxColor,
                child: Center(child: Text(_gestureStatus)),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Scale and Rotation Gestures
            Text(
              '2. Scale & Rotation',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Dùng 2 ngón tay để thu phóng và xoay:',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onScaleStart: (details) {
                setState(() {
                  _gestureStatus = 'Scale/Rotation Started';
                });
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = details.scale;
                  _rotation = details.rotation;
                  _gestureStatus =
                      'Scale: ${_scale.toStringAsFixed(2)}, Rotation: ${(_rotation * 180 / 3.14).toStringAsFixed(2)}°';
                });
              },
              onScaleEnd: (details) {
                setState(() {
                  _gestureStatus = 'Scale/Rotation Ended';
                });
              },
              child: Container(
                height: 150,
                color: Colors.green.withValues(alpha: 0.3),
                child: Center(
                  child: Transform.scale(
                    scale: _scale,
                    child: Transform.rotate(
                      angle: _rotation,
                      child: const FlutterLogo(size: 80),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Drag Gestures
            Text(
              '3. Drag Gestures',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Kéo theo chiều ngang/dọc:',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              color: Colors.grey.withValues(alpha: 0.1),
              child: Stack(
                children: [
                  Positioned(
                    left: _positionX,
                    top: _positionY,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _positionY += details.delta.dy;
                          _gestureStatus =
                              'Vertical position: ${_positionY.toStringAsFixed(1)}';
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _positionX += details.delta.dx;
                          _gestureStatus =
                              'Horizontal position: ${_positionX.toStringAsFixed(1)}';
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.touch_app, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Pan Gesture (Full Movement)
            Text(
              '4. Pan Gesture',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Kéo theo mọi hướng (pan):',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _gestureStatus = 'Pan Started at ${details.localPosition}';
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _offset += details.delta;
                  _gestureStatus = 'Pan Updated: offset = $_offset';
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _gestureStatus =
                      'Pan Ended with velocity: ${details.velocity}';
                });
              },
              child: Container(
                height: 150,
                color: Colors.purple.withValues(alpha: 0.3),
                child: Center(
                  child: Transform.translate(
                    offset: _offset,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.pan_tool, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            // 5. Force Press (iOS)
            Text(
              '5. Force Press',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Nhấn mạnh (chỉ hoạt động trên iOS):',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onForcePressStart: (details) {
                setState(() {
                  _gestureStatus = 'Force Press Started: ${details.pressure}';
                  _boxColor = Colors.red.withValues(alpha: 0.3);
                });
              },
              onForcePressUpdate: (details) {
                setState(() {
                  _gestureStatus = 'Force Press Updated: ${details.pressure}';
                  _boxColor = Colors.red.withValues(
                    alpha: 00.3 + details.pressure * 0.3,
                  );
                });
              },
              onForcePressEnd: (details) {
                setState(() {
                  _gestureStatus = 'Force Press Ended';
                  _boxColor = Colors.blue.withValues(alpha: 0.3);
                });
              },
              child: Container(
                height: 100,
                color: _boxColor,
                child: Center(child: Text(_gestureStatus)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
