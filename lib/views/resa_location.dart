import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OptionPayante {
  int id;
  String libelle;
  String description;
  double prix;

  OptionPayante(this.id, this.libelle,
      {this.description = "", this.prix = 0.0});
}

class OptionPayanteCheck extends OptionPayante {
  bool checked;

  OptionPayanteCheck(this.checked, int id, String libelle,
      {String description = "", double prix = 0.0})
      : super(id, libelle, description: description, prix: prix);
}

class ResaLocation extends StatefulWidget {
  final String adresseMaison;
  final double prixMaison;
  final String libelleHabitation; // Ajout du libellé

  const ResaLocation(
      {Key? key,
      required this.adresseMaison,
      required this.prixMaison,
      required this.libelleHabitation})
      : super(key: key);

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];
  var format = NumberFormat("###,### €");
  double prixTotal = 600.0; // Assuming a base price

  void _loadOptionPayantes() {
    optionPayanteChecks = [
      OptionPayanteCheck(false, 1, 'Draps de lit (30 €)', prix: 30.0),
      OptionPayanteCheck(false, 2, 'Linge de maison (20 €)', prix: 20.0),
      OptionPayanteCheck(false, 3, 'Ménage (60 €)', prix: 60.0),
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadOptionPayantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réservation"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(),
          TotalWidget(prixTotal: prixTotal),
          _buildRentButton(),
        ],
      ),
    );
  }

  Widget _buildResume() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.libelleHabitation, // Utilisation du libellé
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            widget.adresseMaison,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDates() {
    return ListTile(
      title: Text('Dates'),
      onTap: () {
        dateTimeRangePicker();
      },
    );
  }

  void dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
      });
    }
  }

  Widget _buildNbPersonnes() {
    return ListTile(
      title: Text('Nombre de personnes'),
      trailing: DropdownButton<String>(
        value: nbPersonnes,
        onChanged: (String? newValue) {
          setState(() {
            nbPersonnes = newValue!;
          });
        },
        items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionsPayantes() {
    return Column(
      children: optionPayanteChecks.map((option) {
        return CheckboxListTile(
          title: Text(option.libelle),
          subtitle:
              option.description.isNotEmpty ? Text(option.description) : null,
          value: option.checked,
          onChanged: (bool? value) {
            setState(() {
              option.checked = value!;
              _calculateTotal();
            });
          },
        );
      }).toList(),
    );
  }

  void _calculateTotal() {
    prixTotal = optionPayanteChecks
        .fold(widget.prixMaison, (previousValue, option) {
      if (option.checked) {
        return previousValue + option.prix;
      }
      return previousValue;
    });
  }

  Widget _buildRentButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Reservation Submitted'),
              content:
                  Text('Your reservation has been submitted successfully.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text('Louer'),
    );
  }
}

class TotalWidget extends StatelessWidget {
  final double prixTotal;

  const TotalWidget({Key? key, required this.prixTotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("###,### €");

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TOTAL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            format.format(prixTotal),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
