class Word {
  String value;
  List<Definition> definitions;

  Word({this.value, this.definitions});

  factory Word.fromJson(Map<String, dynamic> json) {
    var _definitions = json['definitions'] as List;
    return Word(
      value: json['value'],
      definitions: _definitions.map((d) => Definition.fromJson(d)).toList(),
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
      classification: Classification.fromJson(json['classification']),
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

