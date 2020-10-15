class InfoItem {
  InfoItem({
    this.title,
    this.order,
    this.icon,
    this.description,
    this.confId,
    this.urlLink,
  });

  factory InfoItem.fromJson(Map<String, dynamic> json) {
    return InfoItem(
      title: json['title'] as String,
      order: json['order'] as int,
      icon: json['icon'] as String,
      description: json['description'] as String,
      confId: json['confId'] as String,
      urlLink: json['urlLink'] as String,
    );
  }

  final String title;
  final int order;
  final String icon;
  final String description;
  final String confId;
  final String urlLink;

  Map<String, Object> toJson() {
    return {
      'title': title,
      'order': order,
      'icon': icon,
      'description': description,
      'confId': confId,
      'urlLink': urlLink,
    };
  }
}

class EventItem {
  EventItem({
    this.title,
    this.confId,
    this.type,
    this.category,
    this.shortDescription,
    this.description,
    this.startDate,
    this.endDate,
    this.speaker,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      title: json['title'] as String,
      confId: json['confId'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      speaker: json['speaker'] == null
          ? null
          : Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
    );
  }
  final String title;
  final String confId;
  final String type;
  final String category;
  final String shortDescription;
  final String description;
  final String startDate;
  final String endDate;
  final Speaker speaker;

  Map<String, Object> toJson() {
    return {
      'title': title,
      'confId': confId,
      'type': type,
      'category': category,
      'shortDescription': shortDescription,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'speaker': speaker,
    };
  }
}

class Speaker {
  Speaker({
    this.name,
    this.confIds,
    this.role,
    this.bio,
    this.photoFileUrl,
    this.photoTitle,
    this.photoDescription,
    this.email,
    this.urlGithub,
    this.urlLinkedIn,
    this.urlTwitter,
    this.urlWww,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      name: json['name'] as String,
      confIds: json['confIds'] as String,
      role: json['role'] as String,
      bio: json['bio'] as String,
      photoFileUrl: json['photoFileUrl'] as String,
      photoTitle: json['photoTitle'] as String,
      photoDescription: json['photoDescription'] as String,
      email: json['email'] as String,
      urlGithub: json['urlGithub'] as String,
      urlLinkedIn: json['urlLinkedIn'] as String,
      urlTwitter: json['urlTwitter'] as String,
      urlWww: json['urlWww'] as String,
    );
  }

  final String name;
  final String confIds;
  final String role;
  final String bio;
  final String photoFileUrl;
  final String photoTitle;
  final String photoDescription;
  final String email;
  final String urlGithub;
  final String urlLinkedIn;
  final String urlTwitter;
  final String urlWww;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'confIds': confIds,
      'role': role,
      'bio': bio,
      'photoFileUrl': photoFileUrl,
      'photoTitle': photoTitle,
      'photoDescription': photoDescription,
      'email': email,
      'urlGithub': urlGithub,
      'urlLinkedIn': urlLinkedIn,
      'urlTwitter': urlTwitter,
      'urlWww': urlWww,
    };
  }
}

class SimpleContent {
  SimpleContent({
    this.myId,
    this.title,
    this.text,
    this.confId,
  });

  factory SimpleContent.fromJson(Map<String, dynamic> json) {
    return SimpleContent(
      myId: json['myId'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
      confId: json['confId'] as String,
    );
  }

  final String myId;
  final String title;
  final String text;
  final String confId;

  Map<String, Object> toJson() {
    return {
      'myId': myId,
      'title': title,
      'text': text,
      'confId': confId,
    };
  }
}

class Workshop {
  Workshop({
    this.title,
    this.confId,
    this.description,
    this.speaker,
    this.startDate,
    this.endDate,
    this.locationDescription,
    this.pricePln,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      title: json['title'] as String,
      confId: json['confId'] as String,
      description: json['description'] as String,
      speaker: json['speaker'] == null
          ? null
          : Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      locationDescription: json['locationDescription'] as String,
      pricePln: json['pricePln'] as String,
    );
  }

  final String title;
  final String confId;
  final String description;
  final Speaker speaker;
  final String startDate;
  final String endDate;
  final String locationDescription;
  final String pricePln;

  Map<String, Object> toJson() {
    return {
      'title': title,
      'confId': confId,
      'description': description,
      'speaker': speaker,
      'startDate': startDate,
      'endDate': endDate,
      'locationDescription': locationDescription,
      'pricePln': pricePln,
    };
  }
}
