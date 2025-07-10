import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(
              'https://developer.android.com/static/codelabs/jetpack-compose-animation/img/jetpack_compose_logo_with_rocket.png?hl=vi',
            ), // Ảnh đại diện giả lập
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Jacket Compose',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Jacket Compose là một nhà phát triển ứng dụng di động với hơn 5 năm kinh nghiệm trong việc phát triển ứng dụng Android và iOS. Tôi đã làm việc với nhiều công nghệ như Flutter, React Native và Swift.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Press me',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
