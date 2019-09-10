class Word {
  String value;
  List<Definition> definitions;

  Word({this.value, this.definitions});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      value: json['value'],
      definitions: json['definitions'],
    );
  }
}

class Definition {
  String value;
  Classification classification;

  Definition({this.value, this.classification});

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      value: json['value'],
      classification: json['classification'],
    );
  }
}

class Classification {
  String value;

  Classification({this.value});

  factory Classification.fromJson(Map<String, dynamic> json) {
    return Classification(
      value: json['value'],
    );
  }
}