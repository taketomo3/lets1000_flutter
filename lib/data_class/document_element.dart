class DocumentElement {
  int groupId;
  int id;
  String title;
  String? value;
  String? url;

  DocumentElement({
    required this.groupId,
    required this.id,
    required this.title,
    this.value,
    this.url,
  });
}
