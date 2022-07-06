class AlphabetModel {
  String Alphabet_id;
  String Alphabet_Arabic;
  String wordExample;

  AlphabetModel(this.Alphabet_id, this.Alphabet_Arabic, this.wordExample);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'Alphabet_id': Alphabet_id,
      'Alphabet_Arabic': Alphabet_Arabic,
      'wordExample': wordExample,
    };
    return map;
  }

  AlphabetModel.fromMap(Map<String, dynamic> map) :Alphabet_id=map['Alphabet_id'], Alphabet_Arabic = map['Alphabet_Arabic'], wordExample = map['wordExample'];


}