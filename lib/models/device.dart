//Untuk memudahkan penulisan/pembuatan database, terutama espId dan nama
class Device {
  final String espId;
  final String name;
  final String location;

  Device({
    required this.espId,
    required this.name,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
        'espId': espId,
        'name': name,
        'location': location,
      };

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        espId: json['espId'] as String,
        name: json['name'] as String,
        location: json['location'] as String,
      );
}