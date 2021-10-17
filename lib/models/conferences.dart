class Conferences {
  Conferences({
    this.confId,
    this.confName,
    this.description,
    this.conferencesStartDate,
  });

  factory Conferences.fromJson(Map<String, dynamic> json) {
    return Conferences(
      confId: json['confId'] as String,
      confName: json['confName'] as String,
      description: json['description'] as String,
      conferencesStartDate: json['conferencesStartDate'] as String,
    );
  }

  final String confId;
  final String confName;
  final String description;
  final String conferencesStartDate;

  Map<String, Object> toJson() {
    return {
      'confId': confId,
      'confName': confName,
      'description': description,
      'conferencesStartDate': conferencesStartDate,
    };
  }
}
