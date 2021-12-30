import 'package:isar_generator/src/object_info.dart';
import 'package:dartx/dartx.dart';

String generateSortBy(ObjectInfo oi) {
  var code = '''
  extension ${oi.dartName}QueryWhereSortBy on QueryBuilder<${oi.dartName}, ${oi.dartName}, QSortBy> {''';

  for (var property in oi.properties) {
    if (property.isarType.isList) continue;

    code += '''
    QueryBuilder<${oi.dartName}, ${oi.dartName}, QAfterSortBy>sortBy${property.dartName.capitalize()}() {
      return addSortByInternal('${property.dartName}', Sort.asc);
    }
    
    QueryBuilder<${oi.dartName}, ${oi.dartName}, QAfterSortBy>sortBy${property.dartName.capitalize()}Desc() {
      return addSortByInternal('${property.dartName}', Sort.desc);
    }''';
  }

  code += '''
  }

  extension ${oi.dartName}QueryWhereSortThenBy on QueryBuilder<${oi.dartName}, ${oi.dartName}, QSortThenBy> {''';

  for (var property in oi.properties) {
    if (property.isarType.isList) continue;

    code += '''
    QueryBuilder<${oi.dartName}, ${oi.dartName}, QAfterSortBy>thenBy${property.dartName.capitalize()}() {
      return addSortByInternal('${property.dartName}', Sort.asc);
    }
    
    QueryBuilder<${oi.dartName}, ${oi.dartName}, QAfterSortBy>thenBy${property.dartName.capitalize()}Desc() {
      return addSortByInternal('${property.dartName}', Sort.desc);
    }''';
  }
  code += '}';

  return code;
}
