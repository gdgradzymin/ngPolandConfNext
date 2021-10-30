class Conferences {
  Conferences({
    this.confId,
    this.confName,
    this.description,
    this.conferencesStartDate,
    this.listItems,
  });

  factory Conferences.fromJson(Map<String, dynamic> json) {
    return Conferences(
      confId: json['confId'] as String ?? null,
      confName: json['confName'] as String ?? null,
      description: json['description'] as String ?? null,
      conferencesStartDate: json['conferencesStartDate'] != null ? json['conferencesStartDate'] as String : null,
      listItems: json['conferenceHomePageSchedule'] != null
          ? (json['conferenceHomePageSchedule']['items'] as List<dynamic>)
              .map((dynamic e) => ConferenceHomePageScheduleItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final String confId;
  final String confName;
  final String description;
  final String conferencesStartDate;
  final List<ConferenceHomePageScheduleItem> listItems;

  Map<String, Object> toJson() {
    Map<String, List<Map<String, Object>>> _listItems = {
      'items': listItems.map((e) => e.toJson()).toList(),
    };

    return {
      'confId': confId,
      'confName': confName,
      'description': description,
      'conferencesStartDate': conferencesStartDate,
      'conferenceHomePageSchedule': _listItems,
    };
  }
}

class ConferenceHomePageScheduleItem {
  ConferenceHomePageScheduleItem({
    this.name,
    this.desc,
  });

  factory ConferenceHomePageScheduleItem.fromJson(Map<String, dynamic> json) {
    return ConferenceHomePageScheduleItem(
      name: json['name'] as String ?? null,
      desc: json['desc'] as String ?? null,
    );
  }

  final String name;
  final String desc;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'desc': desc,
    };
  }
}
