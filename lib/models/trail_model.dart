class TrailModel {
  Object trails;
  TrailModel(this.trails);
  TrailModel.fromJson(Map<String, dynamic> parsedJson) {
    trails = parsedJson['trails'];
  }
}
