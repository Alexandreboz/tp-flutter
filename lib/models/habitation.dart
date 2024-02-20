class Habitation {
  int id;
  TypeHabitat typeHabitat;
  String image;
  String libelle;
  String adresse;
  int chambres;
  int superficie;
  double prixmois;

  Habitation(this.id, this.typeHabitat, this.image, this.libelle, this.adresse, this.chambres, this.superficie, this.prixmois);
}

class TypeHabitat {
  int id;
  String libelle;

  TypeHabitat(this.id, this.libelle);
}