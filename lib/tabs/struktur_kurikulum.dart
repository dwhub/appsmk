import 'package:flutter/material.dart';
import 'package:kurikulumsmk/pages/kurikulum_detail.dart';

class KurikulumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                ),
                trailing: IconButton(icon: Icon(Icons.cancel), onPressed: () {
                  //controller.clear();
                  //onSearchTextChanged('');
                }),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
              EntryItem(context, data[index]),
            itemCount: data.length,
          )
        )
      ]
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, this.id, [this.children = const <Entry>[]]);

  final String title;
  final int id;
  final List<Entry> children;
}

// Dummy data
final List<Entry> data = <Entry>[
  Entry(
    '1. Teknologi dan Rekayasa', 0,
    <Entry>[
      Entry(
        '  1.1. Teknik Konstruksi dan Properti', 1,
        <Entry>[
          Entry('    1.1.1. Konstruksi Gedung, Sanitasi, dan Perawatan', 2),
          Entry('    1.1.2. Konstruksi Jalan, Irigasi dan Jembatan', 3),
          Entry('    1.1.3. Bisnis Konstruksi dan Properti', 4),
        ],
      ),
      Entry('  1.2. Teknik Geomatika dan Geospasial', 5),
      Entry('  1.3. Teknik Ketenagalistrikan', 6),
      Entry('  1.4. Teknik Mesin', 7),
      Entry('  1.5. Teknologi Pesawat Udara', 8),
      Entry('  1.6. Teknik Grafika', 9)
    ],
  ),
  Entry(
    '2. Energi dan Pertambangan', 10,
    <Entry>[
      Entry('  2.1. Teknik Perminyakan', 11),
      Entry('  2.2. Geologi Pertambangan', 12),
    ],
  ),
  Entry(
    '3. Teknologi Informasi dan Komunikasi', 13,
    <Entry>[
      Entry('  3.1. Teknik Komputer dan Informatika', 14),
      Entry('  3.2. Teknik Telekomunikasi', 15),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.context, this.entry);

  final Entry entry;
  final BuildContext context;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title), onTap: () { 
      debugPrint(root.id.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KurikulumDetailScreen(root.id),
        ),
      );
    });
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}