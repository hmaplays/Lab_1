import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const QuickShop());
}

class Product {
  Product(this.name, this.price, this.description, this.icon, this.color);
  final String name;
  final double price;
  final String description;
  final IconData icon;
  final Color color;
  bool favourite = false;
}

class QuickShop extends StatelessWidget {
  const QuickShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff177e76)),
        scaffoldBackgroundColor: const Color(0xfff8faf9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xfff8faf9),
          centerTitle: false,
          foregroundColor: Color(0xff1b3435),
        ),
      ),
      home: const IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const ShopHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff177e76),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 106, height: 106,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: .16),
                  borderRadius: BorderRadius.circular(24)),
              child: const Icon(Icons.shopping_bag, size: 64, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text('QuickShop', style: TextStyle(fontSize: 37,
                fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            const Text('Welcome! Find your favourite products.',
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 45),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  final List<Product> products = [
    Product('Wireless Headphones', 59.99, 'Comfortable wireless headphones with clear sound.',
        Icons.headphones, const Color(0xffe6f1f5)),
    Product('Smart Watch', 89.00, 'Track fitness and notifications throughout the day.',
        Icons.watch, const Color(0xfff4e9df)),
    Product('Travel Backpack', 39.50, 'A strong backpack for everyday use and travel.',
        Icons.backpack, const Color(0xffedf0e1)),
    Product('Sneakers', 74.00, 'Lightweight shoes made for daily walking.',
        Icons.directions_run, const Color(0xfff6e6ea)),
  ];

  String page = 'Home';
  int cart = 0;

  void message(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void choose(String option) {
    Navigator.pop(context);
    setState(() => page = option);
  }

  void details(Product item) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: ListView(padding: const EdgeInsets.all(22), children: [
          Container(height: 240,
            decoration: BoxDecoration(color: item.color,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(item.icon, size: 118, color: const Color(0xff177e76))),
          const SizedBox(height: 25),
          Text(item.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('\$' + item.price.toStringAsFixed(2),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xff177e76))),
          const SizedBox(height: 16),
          const Text('Description', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(item.description, style: const TextStyle(fontSize: 15, height: 1.5)),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: () {
              setState(() => cart++);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(item.name + ' added to cart')));
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to Cart'),
          ),
        ]),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (page == 'Add Product') {
      body = AddProductForm(onSaved: (name, price, description) {
        setState(() {
          products.add(Product(name, price, description,
            Icons.shopping_bag_outlined, const Color(0xffe7f1eb)));
          page = 'Home';
        });
        message('Product added successfully');
      });
    } else if (page == 'Gestures & Animation') {
      body = const GestureDemo();
    } else if (page == 'WebView') {
      body = const WebPage();
    } else {
      body = ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 24), children: [
        if (page == 'Home')
          Container(
            padding: const EdgeInsets.all(22),
            margin: const EdgeInsets.only(bottom: 22),
            decoration: BoxDecoration(
              color: const Color(0xff176c68),
              borderRadius: BorderRadius.circular(19)),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WELCOME TO QUICKSHOP', style: TextStyle(
                    fontSize: 11, letterSpacing: 1.4, color: Color(0xffbce3dc))),
                SizedBox(height: 10),
                Text('Find something\nyou love.', style: TextStyle(
                    fontSize: 29, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Text('Everyday items at a glance', style: TextStyle(color: Colors.white70)),
              ]),
          ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Available products', style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold)),
          Text('${products.length} items'),
        ]),
        const SizedBox(height: 14),
        GridView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12,
              childAspectRatio: .77),
          itemBuilder: (context, index) {
            final item = products[index];
            return GestureDetector(
              onTap: () => details(item),
              onDoubleTap: () => setState(() {
                item.favourite = !item.favourite;
                message(item.favourite ? 'Added to favourites' : 'Removed from favourites');
              }),
              onLongPress: () => showModalBottomSheet(
                context: context,
                builder: (_) => ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.name),
                  subtitle: const Text('Long press detected'),
                  trailing: const Icon(Icons.info_outline)),
              ),
              child: Card(
                color: Colors.white, elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xffe4eae8)),
                  borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: Stack(children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: item.color,
                          borderRadius: BorderRadius.circular(12)),
                        child: Icon(item.icon, size: 60, color: const Color(0xff267c73))),
                      if (item.favourite)
                        const Positioned(top: 8, right: 8,
                          child: Icon(Icons.favorite, color: Colors.redAccent)),
                    ])),
                    const SizedBox(height: 10),
                    Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 7),
                    Text('\$' + item.price.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.bold,
                        color: Color(0xff177e76))),
                  ]),
                ),
              ),
            );
          },
        ),
      ]);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(page == 'Home' ? 'QuickShop' : page),
        actions: [
          const Icon(Icons.shopping_bag_outlined),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
            child: Center(child: Text('$cart')),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xff177e76)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.shopping_bag, size: 43, color: Colors.white),
              SizedBox(height: 16),
              Text('QuickShop', style: TextStyle(fontSize: 24,
                fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Mobile Computing - Lab 1',
                style: TextStyle(color: Colors.white70)),
            ]),
          ),
          for (final entry in <String, IconData>{
            'Home': Icons.home_outlined,
            'Products': Icons.grid_view_rounded,
            'Add Product': Icons.add_circle_outline,
            'Gestures & Animation': Icons.touch_app_outlined,
            'WebView': Icons.language,
          }.entries)
            ListTile(
              leading: Icon(entry.value),
              title: Text(entry.key),
              selected: page == entry.key,
              onTap: () => choose(entry.key),
            ),
        ]),
      ),
      body: body,
      floatingActionButton: (page == 'Home' || page == 'Products')
        ? FloatingActionButton.extended(
            onPressed: () => setState(() => page = 'Add Product'),
            icon: const Icon(Icons.add), label: const Text('Add Product'))
        : null,
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key, required this.onSaved});
  final void Function(String, double, String) onSaved;

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();

  @override
  void dispose() {
    name.dispose(); price.dispose(); description.dispose();
    super.dispose();
  }

  void save() {
    if (!form.currentState!.validate()) return;
    final productName = name.text.trim();
    final productPrice = double.parse(price.text.trim());
    final details = description.text.trim();
    name.clear(); price.clear(); description.clear();
    form.currentState!.reset();
    widget.onSaved(productName, productPrice, details);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(key: form, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Add a new product', style: TextStyle(fontSize: 24,
          fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Enter the product information below.'),
        const SizedBox(height: 24),
        TextFormField(controller: name,
          decoration: const InputDecoration(labelText: 'Product Name',
            border: OutlineInputBorder()),
          validator: (v) => (v ?? '').trim().isEmpty
              ? 'Please enter a product name' : null),
        const SizedBox(height: 16),
        TextFormField(controller: price,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Product Price',
            prefixText: '\$\u0024 ', border: OutlineInputBorder()),
          validator: (v) {
            final amount = double.tryParse((v ?? '').trim());
            return amount == null || !amount.isFinite || amount <= 0
                ? 'Enter a valid price above zero' : null;
          }),
        const SizedBox(height: 16),
        TextFormField(controller: description, maxLines: 4,
          decoration: const InputDecoration(labelText: 'Product Description',
            alignLabelWithHint: true, border: OutlineInputBorder()),
          validator: (v) => (v ?? '').trim().isEmpty
              ? 'Please enter a description' : null),
        const SizedBox(height: 22),
        SizedBox(width: double.infinity,
          child: FilledButton.icon(onPressed: save,
            icon: const Icon(Icons.add), label: const Text('Add Product'))),
      ])),
    );
  }
}

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});
  @override
  State<GestureDemo> createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  String result = 'Swipe in any direction';
  double dx = 0, dy = 0;
  bool enlarged = false;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Gesture practice', style: TextStyle(
          fontSize: 23, fontWeight: FontWeight.bold)),
      const SizedBox(height: 7),
      const Text('On the Home screen: tap, double-tap or long-press a product.'),
      const SizedBox(height: 20),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: (_) => dx = 0,
        onHorizontalDragUpdate: (d) => dx += d.delta.dx,
        onHorizontalDragEnd: (_) => setState(
          () => result = dx < 0 ? 'Swiped left' : 'Swiped right'),
        onVerticalDragStart: (_) => dy = 0,
        onVerticalDragUpdate: (d) => dy += d.delta.dy,
        onVerticalDragEnd: (_) => setState(
          () => result = dy < 0 ? 'Dragged up' : 'Dragged down'),
        child: Container(height: 155,
          decoration: BoxDecoration(color: const Color(0xffe1f2ef),
            borderRadius: BorderRadius.circular(16)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.swipe, size: 44, color: Color(0xff177e76)),
            const SizedBox(height: 8),
            const Text('SWIPE / DRAG HERE',
              style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(result),
          ]),
        ),
      ),
      const SizedBox(height: 25),
      const Text('AnimatedContainer', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('Tap the box to see the animation.'),
      const SizedBox(height: 14),
      Center(child: GestureDetector(
        onTap: () => setState(() => enlarged = !enlarged),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          height: enlarged ? 126 : 92, width: enlarged ? 265 : 177,
          decoration: BoxDecoration(
            color: enlarged ? Colors.deepOrangeAccent : const Color(0xff177e76),
            borderRadius: BorderRadius.circular(enlarged ? 32 : 15)),
          child: Center(child: Text(enlarged ? 'Expanded!' : 'Tap to animate',
            style: const TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold))),
        ),
      )),
      const SizedBox(height: 26),
      const Text('Counter using setState()', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton.filledTonal(
          onPressed: () => setState(() => counter--),
          icon: const Icon(Icons.remove), tooltip: 'Decrement'),
        Text('$counter', style: const TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold)),
        IconButton.filled(
          onPressed: () => setState(() => counter++),
          icon: const Icon(Icons.add), tooltip: 'Increment'),
      ]),
    ]);
  }
}

class WebPage extends StatefulWidget {
  const WebPage({super.key});
  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late final WebViewController controller;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (value) => setState(() => progress = value),
        onWebResourceError: (error) {
          if (error.isForMainFrame == true && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.description)));
          }
        },
      ))
      ..loadRequest(Uri.parse('https://example.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (progress < 100) LinearProgressIndicator(value: progress / 100),
      const Padding(padding: EdgeInsets.all(10),
        child: Text('Website: https://example.com')),
      Expanded(child: WebViewWidget(controller: controller)),
    ]);
  }
}
