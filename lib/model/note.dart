class NoteData {
  int? _id;
  String? _title;
  String? _description;
  String? _date;
  int? _item;

  // Constructor with named parameters
  NoteData([this._title, this._item, this._date, this._description]);

  // // Constructor for creating an instance with ID
  // NoteData.withId(this._id, this._title, this._item, this._date,
  //     [this._description]);

  int? get id => _id;

  String get title => _title ?? "";

  String get description => _description ?? "";

  int get item => _item ?? 0;

  String get date => _date ?? "";

  set title(String newTitle) {
    if (newTitle.length <= 50) {
      _title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 250) {
      _description = newDescription;
    }
  }

  set item(int newItem) {
    if (newItem >= 1 && newItem <= 2) {
      _item = newItem;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map["id"] = _id;
    }
    map["title"] = _title;
    map["description"] = _description;
    map["date"] = _date;
    map["item"] = _item;
    return map;
  }

  NoteData.formMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _title = map["title"];
    _description = map["description"];
    _date = map["date"];
    _item = map["item"];
  }
}
