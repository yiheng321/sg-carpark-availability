import 'package:flutter/material.dart';
import 'package:sg_carpark_availability/Controller/PlaceAutoComplete.dart';
import 'package:sg_carpark_availability/Entity/Place.dart';

class AddressSearch extends SearchDelegate<Suggestion?> {
  late PlaceApiProvider apiClient;
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(12.0),
              //child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data?[index])!.description),
                    onTap: () {
                      close(context, snapshot.data?[index]);
                    },
                  ),
                  itemCount: snapshot.data!.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}