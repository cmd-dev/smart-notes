import 'package:smart_notes/models/listenable_model.dart';
import 'package:smart_notes_business/entities.dart';
import 'package:intl/intl.dart';

class NoteItemModel extends ListenableModel {
  NoteItemModel({
    this.id,
    this.tag,
    this.created,
    this.lastModified,
    String title,
    String content,
    bool isSelected,
  }) {
    this.title = title;
    this.content = content;
    this.isSelected = false;
  }

  final String id;
  final DateTime created;
  final DateTime lastModified;
  final TagEntity tag;

  String _title;
  String get title => _title;
  set title(String value) {
    if (_title == value) {
      _title = value;
      return;
    }
    _title = value;
    notifyListeners('title');
  }

  String _content;
  String get content => _content;
  set content(String value) {
    if (_content == value) {
      _content = value;
      return;
    }
    _content = value;
    notifyListeners('content');
  }

  bool _isSelected;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    if (_isSelected == value) {
      _isSelected = value;
      return;
    }
    _isSelected = value;
    notifyListeners('isSelected');
  }

  String get formattedCreated {
    if (created != null)
      return 'Created: ${DateFormat.jm().format(created)} ${DateFormat.yMMMMEEEEd().format(created)}';
    else
      return null;
  }

  String get formattedLastModified {
    if (lastModified != null)
      return 'Last modified: ${DateFormat.jm().format(lastModified)} ${DateFormat.yMMMMEEEEd().format(lastModified)}';
    else
      return null;
  }
}
