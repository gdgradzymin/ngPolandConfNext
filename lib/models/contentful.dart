class InfoItem {
  final String title;
  final String order;
  final String icon;
  final String description;
  final String confId;
  final String urlLink;

  InfoItem({
    this.title,
    this.order,
    this.icon,
    this.description,
    this.confId,
    this.urlLink,
  });
}

class EventItem {
  final String title;
  final String confId;
  final String type;
  final String category;
  final String shortDescription;
  final String description;
  final String startDate;
  final String endDate;
  final Speaker speaker;

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
}

class Speaker {
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
}

class SimpleContent {
  final String myId;
  final String title;
  final String text;
  final String confId;

  SimpleContent({
    this.myId,
    this.title,
    this.text,
    this.confId,
  });
}

class WorkShop {
  final String title;
  final String confId;
  final String description;
  final Speaker speaker;
  final String startDate;
  final String endDate;
  final String locationDescription;
  final String pricePln;

  WorkShop({
    this.title,
    this.confId,
    this.description,
    this.speaker,
    this.startDate,
    this.endDate,
    this.locationDescription,
    this.pricePln,
  });
}
