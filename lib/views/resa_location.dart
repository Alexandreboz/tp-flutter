import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/habitation.dart';

import '../models/habitation.dart';

class ResaLocation extends StatefulWidget {
  const ResaLocation({super.key});

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {

  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];

  var format = NumberFormat("### €");

  @override
  Widget build(BuildContext context) {
    //_loadOptionPayantes();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Réservation",
            style: TextStyle(
              color: Colors.white70, // Couleur du texte en bleu
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
    padding: EdgeInsets.all(4.0),
    children: [
    _buildResume(),
    //_buildDates(),
    //_buildNbPersonnes(),
    //_buildOptionsPayantes(context),
    //TotalWidget(prixTotal),
    //_buildRentButton(),
    ],

    ));
  }

  _buildResume() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return ListTile(
      leading: Icon(Icons.home), // Logo d'une maison
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Maison",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4), // Espacement
          Text(
            'Adresse de la maison',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class OptionPayanteCheck extends OptionPayante {
  bool checked;

  OptionPayanteCheck(super.id, super.libelle, this.checked,
      {super.description = "", super.prix});
}
