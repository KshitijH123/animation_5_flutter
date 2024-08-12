import 'package:flutter/material.dart';

class AnimatedCirclesScreen extends StatefulWidget {
  @override
  _AnimatedCirclesScreenState createState() => _AnimatedCirclesScreenState();
}

class _AnimatedCirclesScreenState extends State<AnimatedCirclesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.5, 0.5),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 100,
                    left: 100,
                    child: SlideTransition(
                      position: _positionAnimation,
                      child: ScaleTransition(
                        scale: _sizeAnimation,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: _colorAnimation.value,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: 200,
                    child: SlideTransition(
                      position: _positionAnimation,
                      child: ScaleTransition(
                        scale: _sizeAnimation,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: _colorAnimation.value?.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      
      ),
    
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
