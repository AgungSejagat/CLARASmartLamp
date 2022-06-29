class Room {
  final String id;
  final String location; //

  Room({
    required this.id,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location,
      };

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json['id'] as String,
        location: json['location'] as String,
      );
}
