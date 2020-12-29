class ListData {
  ListData({
    this.code,
    this.meta,
    this.data,
  });

  int code;
  Meta meta;
  List<Datum> data;

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
    code: json["code"],
    meta: Meta.fromJson(json["meta"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  Gender gender;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: genderValues.map[json["gender"]],
    status: statusValues.map[json["status"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": genderValues.reverse[gender],
    "status": statusValues.reverse[status],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE
});

enum Status { ACTIVE, INACTIVE }

final statusValues = EnumValues({
  "Active": Status.ACTIVE,
  "Inactive": Status.INACTIVE
});

class Meta {
  Meta({
    this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    this.total,
    this.pages,
    this.page,
    this.limit,
  });

  int total;
  int pages;
  int page;
  int limit;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    pages: json["pages"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "pages": pages,
    "page": page,
    "limit": limit,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}