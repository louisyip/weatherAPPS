class SaveCity {
  String title;
  String id;
  String cityname;
  SaveCity(
      {this.title, this.id, this.cityname});

  SaveCity copy() {
    return SaveCity(
        title: this.title,
        id: this.id,
        cityname: this.cityname);
  }
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'title': this.title,
        'id': this.id,
        'cityname': this.cityname
      };
  String toString() {
    return 'Title: ' + ((this.title == null) ? '' : this.title) + '\n'+'id: ' + ((this.id == null) ? '' : this.id) + '\n'+'cityname: ' + ((this.cityname == null) ? '' : this.cityname) + '\n';
  }
}
