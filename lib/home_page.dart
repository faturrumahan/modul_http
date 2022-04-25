import 'package:flutter/material.dart';
import 'package:modul_http/countries_model.dart';
import 'package:modul_http/covid_data_source.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries Detail"),
      ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (BuildContext context,
            AsyncSnapshot<dynamic> snapshot,) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CountriesModel data) {
    return ListView.builder(
      itemCount: data.countries?.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCountries("${data.countries?[index].name}", "${data.countries?[index].iso3}");
      },
    );
  }

  Widget _buildItemCountries(String value1, String value2) {
    //return Text(value1);
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: (){
          debugPrint(value1);
        },
        child: SizedBox(
          height: 100,
          child: Center(
            child: Column(
              children: [
                Text(value1),
                Text(value2)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
