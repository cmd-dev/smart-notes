import 'package:smart_notes_business/mappers.dart';
import 'package:smart_notes_business/src/entities/notes/note_entity.dart';
import 'package:smart_notes_business/src/mappers/base/entity_mapper.dart';
import 'package:smart_notes_data/database.dart';

abstract class NoteMapper
    implements EntityDataObjectMapper<NoteEntity, NoteDataObject> {}

class NoteMapperImpl implements NoteMapper {
  @override
  NoteDataObject toDataObject(NoteEntity source) {
    return NoteDataObject(
      id: source.id,
      title: source.title,
      content: source.content,
      tagId: source.tag?.id,
      created: source.created,
      lastModified: source.lastModified,
      ownedBy: source.ownedBy,
    );
  }

  @override
  NoteEntity toEntity(NoteDataObject source) {
    return NoteEntity(
      id: source.id,
      title: source.title,
      content: source.content,
      created: source.created,
      lastModified: source.lastModified,
      ownedBy: source.ownedBy,
    );
  }
}

abstract class NoteWithTagMapper
    implements EntityMapper<NoteEntity, NoteWithTag> {}

class NoteWithTagMapperImpl implements NoteWithTagMapper {
  NoteWithTagMapperImpl(this._tagMapper);

  final TagMapper _tagMapper;

  @override
  NoteEntity toEntity(NoteWithTag source) {
    return NoteEntity(
      id: source.note.id,
      title: source.note.title,
      content: source.note.content,
      ownedBy: source.note.ownedBy,
      created: source.note.created,
      lastModified: source.note.lastModified,
      tag: source.tag != null ? _tagMapper.toEntity(source.tag) : null,
    );
  }
}
