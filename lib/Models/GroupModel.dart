class Group {
  String name;
  String description;
  String icon;
  String id;
  String createdBy = '';
  String category = '';
  List<String> admins = [];
  List<String> members = [];

  Group({
    required this.name,
    required this.description,
    required this.icon,
    required this.id,
    required this.createdBy,
    required this.category,
    required this.admins,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      id: json['id'],
      createdBy: json['createdBy'],
      category: json['category'],
      admins: List<String>.from(json['admins']),
      members: List<String>.from(json['members']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
      'id': id,
      'createdBy': createdBy,
      'category': category,
      'admins': admins,
      'members': members,
    };
  }

  // empty group
  static Group empty() {
    return Group(
      name: '',
      description: '',
      icon: '',
      id: '',
      createdBy: '',
      category: '',
      admins: [],
      members: [],
    );
  }
}
