import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dsw52725_projekt/utils/db_helper.dart';
import 'package:dsw52725_projekt/utils/note.dart';
import 'package:dsw52725_projekt/views/note_detail/note_detail_view.dart';
import 'package:dsw52725_projekt/views/login/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Note>> _notes;

  @override
  void initState() {
    super.initState();
    _notes = DatabaseHelper().getNotes();
  }

  void _refreshNotes() {
    setState(() {
      _notes = DatabaseHelper().getNotes();
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false, // Remove back button
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  _logout();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Note>>(
          future: _notes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading notes');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No notes available');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final note = snapshot.data![index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteDetailView(note: note, onSave: _refreshNotes),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await DatabaseHelper().deleteNote(note.id!);
                        _refreshNotes();
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailView(onSave: _refreshNotes),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
