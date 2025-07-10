import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'gestures_page.dart';

void main() {
  runApp(const MyApp());
}

class ThemeProvider extends InheritedWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ThemeProvider({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required super.child,
  });

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(path: 'text', builder: (context, state) => const TextDemo()),
        GoRoute(path: 'image', builder: (context, state) => const ImageDemo()),
        GoRoute(path: 'input', builder: (context, state) => const InputDemo()),
        GoRoute(
          path: 'buttons',
          builder: (context, state) => const ButtonDemo(),
        ),
        GoRoute(path: 'cards', builder: (context, state) => const CardDemo()),
        GoRoute(
          path: 'layouts',
          builder: (context, state) => const LayoutDemo(),
        ),
        GoRoute(
          path: 'animations',
          builder: (context, state) => const AnimationDemo(),
        ),
        GoRoute(path: 'lists', builder: (context, state) => const ListDemo()),
        GoRoute(
          path: 'gestures',
          builder: (context, state) => const GesturesPage(),
        ),
      ],
    ),
  ],
);

class ComponentItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
  final Color color;

  ComponentItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
  });
}

class ComponentCard extends StatefulWidget {
  final ComponentItem component;
  final VoidCallback onTap;

  const ComponentCard({
    super.key,
    required this.component,
    required this.onTap,
  });

  @override
  State<ComponentCard> createState() => _ComponentCardState();
}

class _ComponentCardState extends State<ComponentCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        child: Card(
          elevation: isHovered ? 8 : 4,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.component.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.component.icon,
                      size: 32,
                      color: widget.component.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.component.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.component.subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Enhanced UI Components',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
      ),
      builder: (context, child) {
        return ThemeProvider(
          isDarkMode: isDarkMode,
          toggleTheme: () => setState(() => isDarkMode = !isDarkMode),
          child: child!,
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    final components = [
      ComponentItem(
        icon: Icons.text_fields,
        title: 'Text Styles',
        subtitle: 'Typography and text formatting',
        route: '/text',
        color: Colors.blue,
      ),
      ComponentItem(
        icon: Icons.image,
        title: 'Images & Media',
        subtitle: 'Image handling and display',
        route: '/image',
        color: Colors.green,
      ),
      ComponentItem(
        icon: Icons.input,
        title: 'Input Fields',
        subtitle: 'Text fields and form inputs',
        route: '/input',
        color: Colors.orange,
      ),
      ComponentItem(
        icon: Icons.smart_button,
        title: 'Buttons',
        subtitle: 'Various button styles',
        route: '/buttons',
        color: Colors.purple,
      ),
      ComponentItem(
        icon: Icons.credit_card,
        title: 'Cards',
        subtitle: 'Card layouts and designs',
        route: '/cards',
        color: Colors.teal,
      ),
      ComponentItem(
        icon: Icons.view_quilt,
        title: 'Layouts',
        subtitle: 'Column, row, and grid layouts',
        route: '/layouts',
        color: Colors.indigo,
      ),
      ComponentItem(
        icon: Icons.animation,
        title: 'Animations',
        subtitle: 'Motion and transitions',
        route: '/animations',
        color: Colors.red,
      ),
      ComponentItem(
        icon: Icons.list,
        title: 'Lists & Grids',
        subtitle: 'List views and grid layouts',
        route: '/lists',
        color: Colors.amber,
      ),
      // ComponentItem(
      //   icon: Icons.palette,
      //   title: 'Themes',
      //   subtitle: 'Dark and light mode switching',
      //   route: '/',
      //   color: Colors.cyan,
      // ),
      ComponentItem(
        icon: Icons.gesture,
        title: 'Gestures',
        subtitle: 'Handling touch gestures',
        route: '/gestures',
        color: Colors.deepOrange,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Components Demo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: components.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 200 + (index * 100)),
                child: ComponentCard(
                  component: components[index],
                  onTap: () => context.go(components[index].route),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Styles'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Typography Scale',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Display Large',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Headline Large',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'Title Large',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Body Large',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Label Large',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rich Text Example',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        text: 'The ',
                        style: const TextStyle(fontSize: 18),
                        children: [
                          TextSpan(
                            text: 'quick ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                            text: 'brown ',
                            style: TextStyle(
                              color: Colors.brown[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const TextSpan(text: 'fox '),
                          const TextSpan(
                            text: 'jumps ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            ),
                          ),
                          const TextSpan(text: 'over the '),
                          TextSpan(
                            text: 'lazy dog.',
                            style: TextStyle(
                              backgroundColor: Colors.yellow[200],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDemo extends StatelessWidget {
  const ImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images & Media'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Network Images',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://picsum.photos/300/200',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Avatar Gallery',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://picsum.photos/100/100?random=$index',
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputDemo extends StatefulWidget {
  const InputDemo({super.key});

  @override
  State<InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  bool _obscurePassword = true;
  double _sliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Fields'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Form Inputs',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() => _name = value),
                        validator:
                            (value) =>
                                value?.isEmpty == true
                                    ? 'Please enter your name'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => setState(() => _email = value),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Please enter your email';
                          }
                          if (!value!.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        obscureText: _obscurePassword,
                        onChanged: (value) => setState(() => _password = value),
                        validator:
                            (value) =>
                                value?.length != null && value!.length < 6
                                    ? 'Password must be at least 6 characters'
                                    : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interactive Controls',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      Text('Slider Value: ${_sliderValue.round()}'),
                      Slider(
                        value: _sliderValue,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: _sliderValue.round().toString(),
                        onChanged:
                            (value) => setState(() => _sliderValue = value),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_name.isNotEmpty || _email.isNotEmpty || _password.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Live Preview',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        if (_name.isNotEmpty) Text('Name: $_name'),
                        if (_email.isNotEmpty) Text('Email: $_email'),
                        if (_password.isNotEmpty)
                          Text('Password: ${'*' * _password.length}'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Material Buttons',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Elevated'),
                        ),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Filled'),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Outlined'),
                        ),
                        TextButton(onPressed: () {}, child: const Text('Text')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Icon Buttons',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                        ),
                        IconButton.filled(
                          onPressed: () {},
                          icon: const Icon(Icons.star),
                        ),
                        IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                        ),
                        FloatingActionButton.small(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Buttons',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardDemo extends StatelessWidget {
  const CardDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cards'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://picsum.photos/50/50',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Software Developer',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/400/200',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Beautiful landscape captured during my recent trip to the mountains.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          label: const Text('Like'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.comment_outlined),
                          label: const Text('Comment'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          label: const Text('Share'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.analytics, size: 48, color: Colors.blue),
                          const SizedBox(height: 8),
                          Text(
                            'Analytics',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'View insights',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.settings, size: 48, color: Colors.green),
                          const SizedBox(height: 8),
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Preferences',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layouts'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Column Layout',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(3, (index) {
                        return Container(
                          height: 60,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue[100 * (index + 2)],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Item ${index + 1}')),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grid Layout',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100 * ((index % 8) + 1)],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('${index + 1}')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_rotationController);
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Rotation Animation',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    RotationTransition(
                      turns: _rotationAnimation,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Scale Animation',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: ElevatedButton(
                        onPressed: () {
                          _scaleController.forward().then((_) {
                            _scaleController.reverse();
                          });
                        },
                        child: const Text('Tap to Scale'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Hero Animation',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Hero(
                      tag: 'hero-demo',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HeroDetailPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.touch_app,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Tap to see Hero animation'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail')),
      body: Center(
        child: Hero(
          tag: 'hero-demo',
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.touch_app, color: Colors.white, size: 100),
          ),
        ),
      ),
    );
  }
}

class ListDemo extends StatelessWidget {
  const ListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lists & Grids'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'List View',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key('item-$index'),
                          child: ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text('Item ${index + 1}'),
                            subtitle: Text('Description for item ${index + 1}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Staggered Grid',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.primaries[index %
                                              Colors.primaries.length][100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 40,
                                        color:
                                            Colors.primaries[index %
                                                Colors.primaries.length],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Card ${index + 1}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
