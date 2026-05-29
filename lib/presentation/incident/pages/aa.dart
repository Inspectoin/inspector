import 'dart:async';
import 'dart:math';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'dart:math';

class MockAudioWaveDemo extends StatefulWidget {
  const MockAudioWaveDemo({super.key});

  @override
  State<MockAudioWaveDemo> createState() => _MockAudioWaveDemoState();
}

class _MockAudioWaveDemoState extends State<MockAudioWaveDemo> {
  bool isRecording = false;
  Timer? _timer;
  final Random _rnd = Random();

  // Wave configuration
  final int barCount = 40;
  final double minBarHeight = 6;
  final double maxBarHeight = 40;
  final Duration updateInterval = const Duration(milliseconds: 160);
  final Duration animationDuration = const Duration(milliseconds: 150);

  late List<double> _heights;

  @override
  void initState() {
    super.initState();
    // initialize with minimal heights
    _heights = List<double>.filled(barCount, minBarHeight);
  }

  void _startMockWave() {
    if (isRecording) return;
    setState(() => isRecording = true);

    _timer = Timer.periodic(updateInterval, (_) {
      setState(() {
        _heights = List.generate(
          barCount,
              (i) {
            // create a more "natural" wave by using a base sine + randomness
            final base = (sin((DateTime.now().millisecondsSinceEpoch / 1000.0) * (0.6 + i * 0.03) + i) + 1) / 2;
            final noise = _rnd.nextDouble() * 0.6;
            final value = minBarHeight + (base * (1 - noise) + noise) * (maxBarHeight - minBarHeight);
            return value;
          },
        );
      });
    });
  }

  void _stopMockWave() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      isRecording = false;
      // shrink back to minimal
      _heights = List<double>.filled(barCount, minBarHeight);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Audio Wave')),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MockOvalWaveDemo(),

            // Wave area
            Container(
              width: 320,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000), // subtle
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: WaveBars(
                  heights: _heights,
                  maxHeight: maxBarHeight,
                  spacing: 4,
                  color: Colors.white,
                  duration: animationDuration,
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Controls
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Record/Stop circular button
                GestureDetector(
                  onTap: () {
                    if (isRecording) {
                      _stopMockWave();
                    } else {
                      _startMockWave();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: isRecording ? Colors.red : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Icon(isRecording ? Icons.stop : Icons.mic, color: Colors.white, size: 34),
                  ),
                ),
                const SizedBox(width: 16),
                // optional status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isRecording ? 'Recording...' : 'Tap to record', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text('Demo mock wave — not real audio', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/// WaveBars: draws a row of animated bars centered vertically
class WaveBars extends StatelessWidget {
  final List<double> heights;
  final double maxHeight;
  final double spacing;
  final Color color;
  final Duration duration;

  const WaveBars({
    super.key,
    required this.heights,
    required this.maxHeight,
    this.spacing = 4,
    this.color = Colors.blue,
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  Widget build(BuildContext context) {
    final int count = heights.length;
    return LayoutBuilder(builder: (context, constraints) {
      final totalSpacing = spacing * (count - 1);
      final barWidth = (constraints.maxWidth - totalSpacing) / count;


      return SizedBox(
        height: maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // 👈 important
          children: List.generate(count, (i) {
            final h = heights[i].clamp(2, maxHeight);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(vertical: 0),
                duration: duration,
                width: 3,//,
                height: h.toDouble(),
                // 👇 Center expansion effect
                alignment: Alignment.center,
                child: Container(
                  width: barWidth,
                  height: h.toDouble(),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(barWidth / 2),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}






class MockOvalWaveDemo extends StatefulWidget {
  const MockOvalWaveDemo({super.key});

  @override
  State<MockOvalWaveDemo> createState() => _MockOvalWaveDemoState();
}

class _MockOvalWaveDemoState extends State<MockOvalWaveDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated circles
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: CircleWavePainter1(_controller),
                  size: const Size(300, 300),
                );
              },
            ),

            // Center container with image
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary2Color, // optional background color

              ),
              child: Center(
                child:  Assets.icons.logo.image(
                  width: 120,
                  height: 120
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CircleWavePainter1 extends CustomPainter {
  final Animation<double> animation;
  CircleWavePainter1(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final int circleCount = 5;

    // Larger base sizes for the circles
    final List<double> baseRadii = [50, 60, 50, 55, 50]; // increased sizes
    final List<double> baseOpacity = [0.3, 0.5, 0.8, 0.6, 0.35];

    for (int i = 0; i < circleCount; i++) {
      final double progress = (sin((animation.value * 2 * pi) + i) + 1) / 2;

      final double radius = baseRadii[i] + baseRadii[i] * progress; // size animation
      final double opacity = (1 - baseOpacity[i]) * progress;

      paint.color = AppColors.primaryColor.withOpacity(opacity);

      canvas.drawCircle(center, radius, paint);
    }

    // Draw the center circle
    final double centerCircleRadius = 30;
    final Paint centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    canvas.drawCircle(center, centerCircleRadius, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}






class HighlightNewItemList extends StatefulWidget {
  @override
  _HighlightNewItemListState createState() => _HighlightNewItemListState();
}

class _HighlightNewItemListState extends State<HighlightNewItemList> {
  List<String> items = [];
  int? highlightedIndex;

  void _addItem() {
    setState(() {
      items.insert(0,'Item ${items.length + 1}');
      highlightedIndex = 0;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => highlightedIndex = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Highlight New Item')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final isHighlighted = highlightedIndex == index;
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: isHighlighted ? Colors.yellow[200] : Colors.white,
            child: ListTile(
              title: Text(items[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}


class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<String> _items = [];

  void _addItem() {
    final index = _items.length;
    _items.add('Item ${index + 1}');
    _listKey.currentState!.insertItem(0);
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(0, 0.2), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOut)),
        ),
        child: Card(
          margin: const EdgeInsets.all(8),
          color: Colors.blue[100],
          child: ListTile(title: Text(item)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated List')),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) =>
            _buildItem(_items[index], animation),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}


