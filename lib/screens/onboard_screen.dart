import 'dart:ui';
import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  final VoidCallback? onComplete;
  const OnboardScreen({super.key, this.onComplete});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int _page = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < 2) {
      _fadeController.reverse().then((_) {
        _controller.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeInOutExpo);
        _fadeController.forward(from: 0);
      });
    } else {
      if (widget.onComplete != null) widget.onComplete!();
    }
  }

  void _back() {
    if (_page > 0) {
      _fadeController.reverse().then((_) {
        _controller.previousPage(duration: const Duration(milliseconds: 600), curve: Curves.easeInOutExpo);
        _fadeController.forward(from: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: PageView(
              controller: _controller,
              onPageChanged: (i) => setState(() => _page = i),
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              children: [
                FadeTransition(
                  opacity: _fadeAnim,
                  child: _OnboardPage(
                    bgColor: const Color(0xFF2B1B6B),
                    image: 'assets/images/Lineup.jpg',
                    title: '🏎️ McLaren F1',
                    highlight: 'Leading the pack with speed and innovation.',
                    desc: 'McLaren dominates the track with top drivers and championship wins.',
                    buttonText: 'Next',
                    onButton: _next,
                    titleColor: Colors.white,
                    highlightColor: Colors.white,
                    descColor: Colors.white,
                    blur: false,
                  ),
                ),
                FadeTransition(
                  opacity: _fadeAnim,
                  child: _OnboardPage(
                    bgColor: Colors.white,
                    image: 'assets/images/board.jpg',
                    title: '🏁 McLaren & Oscar Piastri – Dutch GP 2025',
                    highlight: 'Oscar Piastri wins the Dutch GP and leads the Drivers Championship',
                    desc: 'Oscar Piastri current points: 309',
                    buttonText: 'Next',
                    onButton: _next,
                    titleColor: Colors.white,
                    highlightColor: Colors.white,
                    descColor: Colors.white,
                    blur: false,
                  ),
                ),
                FadeTransition(
                  opacity: _fadeAnim,
                  child: _OnboardPage(
                    bgColor: const Color(0xFFFF8C1A),
                    image: 'assets/images/Bard.jpg',
                    title: '🏁 Remembering Ayrton Senna',
                    highlight: 'A legendary F1 driver whose spirit still inspires fans worldwide.',
                    desc: 'Three-time F1 World Champion, remembered for his skill, passion, and legacy.',
                    buttonText: "Let's Go",
                    onButton: widget.onComplete ?? _next, // เรียก onComplete โดยตรง
                    ),
                ),
              ],
            ),
          ),
          if (_page > 0)
            Positioned(
              top: 32,
              left: 16,
              child: SafeArea(
                child: AnimatedScale(
                  scale: 1.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.elasticOut,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
                    onPressed: _back,
                    tooltip: 'Back',
                    splashRadius: 28,
                  ),
                ),
              ),
            ),
          // Animated page indicator (ซ้ายล่าง)
          Positioned(
            bottom: 32,
            left: 24,
            child: Row(
              children: List.generate(3, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _page == i ? 28 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _page == i ? Colors.orangeAccent : Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _page == i ? [BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0,2))] : [],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  final Color bgColor;
  final String image;
  final String title;
  final String highlight;
  final String desc;
  final String buttonText;
  final VoidCallback onButton;
  final Color? titleColor;
  final Color? highlightColor;
  final Color? descColor;
  final bool blur;

  const _OnboardPage({
    required this.bgColor,
    required this.image,
    required this.title,
    required this.highlight,
    required this.desc,
    required this.buttonText,
    required this.onButton,
    this.titleColor,
    this.highlightColor,
    this.descColor,
    this.blur = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBoard = image.toLowerCase().contains('board');
    return Container(
      color: bgColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          if (blur)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.black.withOpacity(0.08)),
              ),
            ),
          // Main content (คำบรรยายไว้ล่าง, ปุ่มขวาล่าง)
          if (isBoard)
            // หน้า 2: ข้อความตรงกลางจอ
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor ?? (bgColor == Colors.white ? Colors.black : Colors.white),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0,2))],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      highlight,
                      style: TextStyle(
                        color: highlightColor ?? (bgColor == Colors.white ? const Color(0xFF2B1B6B) : Colors.yellowAccent),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0,2))],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      desc,
                      style: TextStyle(
                        color: descColor ?? (bgColor == Colors.white ? Colors.black87 : Colors.white70),
                        fontSize: 15,
                        shadows: [Shadow(color: Colors.black12, blurRadius: 2, offset: Offset(0,1))],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            // หน้าอื่น: ข้อความล่าง
            Positioned(
              left: 0,
              right: 0,
              bottom: 90,
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 700),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: titleColor ?? (bgColor == Colors.white ? Colors.black : Colors.white),
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0,2))],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        highlight,
                        style: TextStyle(
                          color: highlightColor ?? (bgColor == Colors.white ? const Color(0xFF2B1B6B) : Colors.yellowAccent),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0,2))],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        desc,
                        style: TextStyle(
                          color: descColor ?? (bgColor == Colors.white ? Colors.black87 : Colors.white70),
                          fontSize: 15,
                          shadows: [Shadow(color: Colors.black12, blurRadius: 2, offset: Offset(0,1))],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 24,
            right: 24,
            child: AnimatedScale(
              scale: 1.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor == Colors.white ? const Color(0xFF2B1B6B) : Colors.white,
                  foregroundColor: bgColor == Colors.white ? Colors.white : bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  elevation: 10,
                  shadowColor: Colors.black45,
                ),
                onPressed: onButton,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: bgColor == Colors.white ? Colors.white : bgColor,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
