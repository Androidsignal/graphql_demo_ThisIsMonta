import 'package:flutter/material.dart';
import 'package:graphql_demo/qraphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'country_model.dart';
import 'country_selection_widget.dart';

Future<void> main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GraphQlService _graphQLService = GraphQlService();
  List<CountryModel>? countryList;
  String dropdownValue = 'AS';

  @override
  void initState() {
    super.initState();
    _getCountries(dropdownValue);
  }

  void _getCountries(String dropdownValue) async {
    countryList = null;

    List<CountryModel> countries = await _graphQLService.getCountries(continentCode: dropdownValue);
    setState(() {
      countryList = countries;
      this.dropdownValue = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: CustomDropdown<String>(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                onChange: (String newValue, int index) {
                  _getCountries(newValue);
                },
                dropdownButtonStyle: DropdownButtonStyle(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  elevation: 1,
                  backgroundColor: Colors.white,
                  primaryColor: Colors.black87,
                ),
                dropdownStyle: DropdownStyle(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 6,
                  padding: const EdgeInsets.all(5),
                ),
                items: ['AF', 'AN', 'AS', 'EU', 'NA', 'OC', 'SA']
                    .asMap()
                    .entries
                    .map(
                      (item) => DropdownItem<String>(
                        value: item.value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${item.value} - ${getCountriesName(item.value)}",
                          ),
                        ),
                      ),
                    )
                    .toList(),
                child: Text(
                  "$dropdownValue - ${getCountriesName(dropdownValue)}",
                ),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                if (countryList == null) {
                  return const Center(
                    child: const CircularProgressIndicator(),
                  );
                } else if (countryList!.isEmpty) {
                  return const Center(
                    child: Text('No Books'),
                  );
                } else {
                  return ListView.separated(
                    itemCount: countryList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(countryList?[index].name ?? "", style: Theme.of(context).textTheme.titleMedium),
                        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        subtitle: Text(countryList?[index].capital ?? "", style: Theme.of(context).textTheme.caption),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String getCountriesName(String countryCode) {
    switch (countryCode) {
      case 'AF':
        return 'Africa';
      case 'AN':
        return 'Antarctica';
      case 'AS':
        return 'Asia';
      case 'EU':
        return 'Europe';
      case 'NA':
        return 'North America';
      case 'OC':
        return 'Oceania';
      case 'SA':
        return 'South Africa';
      default:
        return '';
    }
  }
}
