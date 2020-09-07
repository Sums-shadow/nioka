class ScoreModel{
  final int id;
  final String nom;
  final String score;

  ScoreModel({this.id,this.nom,this.score});

  Map<String,dynamic> toMap(){ // utiliser quand on insert une donée dans la bd
    return <String,dynamic>{
      "id" : id,
      "nom" : nom,
      "score" : score,
    };
  }
}