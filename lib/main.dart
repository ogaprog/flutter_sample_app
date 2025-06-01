import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  List<Widget> _pages = [];
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _initCameras();
    _pages = [
      _buildCameraPage(),
      _buildBluetoothPage(),
      _buildWebViewPage(),
    ];
  }

  Future<void> _initCameras() async {
    _cameras = await availableCameras();
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCameraPage() {
    if (_cameras == null || _cameras.isEmpty) {
      return const Center(child: Text('カメラが見つかりません'));
    }
    return CameraPreview(CameraController(_cameras[0], ResolutionPreset.medium));
  }

  Widget _buildBluetoothPage() {
    return StreamBuilder<List<BluetoothDevice>>(
      stream: FlutterBlue.instance.connectedDevices.asStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final devices = snapshot.data!;
        return ListView(
          children: devices.map((d) => ListTile(title: Text(d.name))).toList(),
        );
      },
    );
  }

  Widget _buildWebViewPage() {
    return const WebView(
      initialUrl: 'https://flutter.dev',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'カメラ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Bluetooth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'WebView',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
