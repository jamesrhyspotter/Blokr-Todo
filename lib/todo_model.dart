
class ToDo {

  late String _title;
  late String _description;
  late double _time;
  late bool _done;

  ToDo(this._title, this._description, this._time, this._done);

  isDone(){
    _done = !_done;
  }

}