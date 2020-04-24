import 'package:dark_light/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeChanger>(
            create: (_) => ThemeChanger(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    bool darkThemeEnabled = Provider.of<ThemeChanger>(context).isDark();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.purple[200],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.purpleAccent,
      ),
      themeMode: darkThemeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeChanger themeChanger;
  bool systemIsDark;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeChanger.setDarkStatus(systemIsDark);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    themeChanger = Provider.of<ThemeChanger>(context, listen: false);
    systemIsDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: Theme.of(context).primaryColorDark.withOpacity(.4),
            child: Center(
              child: Text(
                'Lista de items',
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(8, (index == 0) ? 8 : 0, 8, 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    leading: Image.network('https://i.picsum.photos/id/$index/300/300.jpg'),
                    title: Text(
                      'Um item da lista',
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    subtitle: Text(
                      'Algo importante a dizer',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite_border),
                      color: Theme.of(context).accentColor,
                      onPressed: () => null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Dark Theme'),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value: themeChanger.isDark(),
                onChanged: (changedTheme) {
                  themeChanger.setDarkStatus(changedTheme);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
