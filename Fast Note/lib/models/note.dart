class Note {
  int id;
  String? name; // Tornar o parâmetro 'name' opcional usando '?'
  String text;

  Note({
    required this.id,
    this.name, // Tornar o parâmetro 'name' opcional usando '?'
    required this.text,
  });
}
