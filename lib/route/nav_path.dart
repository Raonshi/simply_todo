enum NavPath {
  home("/"),
  addTodo("/addTodo");

  final String _path;
  String get path => _path;

  const NavPath(this._path);
}
