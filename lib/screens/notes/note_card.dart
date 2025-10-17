import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/routes/route_names.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          // Navigate and wait for return, then refresh
          await Navigator.pushNamed(
            context,
            RouteNames.noteEdit,
            arguments: note.id,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              // Title - Top Left
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Subtext - Below Title
              Positioned(
                top: 40, // Space for title
                left: 0,
                right: 0,
                bottom: 20, // Space for date
                child: Text(
                  note.subText.isEmpty ? "No additional text" : note.subText,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Date - Bottom Right
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  note.displayDate,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
