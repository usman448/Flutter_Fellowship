import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart'; // pubspec mein add karo

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final box = Hive.box('notesBox');

  // Purple accent shades cycle karte hain notes par
  final List<Color> _accents = [
    Color(0xFF7C55E0),
    Color(0xFFC084FC),
    Color(0xFF818CF8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0B14),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0B14),
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Color(0xFF7C55E0), Color(0xFF4A2FA0)],
                ),
              ),
              child: Icon(Icons.auto_stories_rounded,
                  size: 16, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text(
              "Nota",
              style: TextStyle(
                color: Color(0xFFE9D5FF),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "${box.length} notes",
                style: TextStyle(
                  color: Color(0xFF6D5A8A),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(color: Color(0xFF2A2040), height: 0.5),
        ),
      ),

      body: Column(
        children: [
          // Input row
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1626),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF3D3060), width: 0.5),
                    ),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                          color: Color(0xFFD4B8FF), fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Add a new note...",
                        hintStyle: TextStyle(
                            color: Color(0xFF4A3F6B),
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (controller.text.trim().isEmpty) return;
                    box.add({
                      'text': controller.text.trim(),
                      'time': DateTime.now().toIso8601String(),
                    });
                    controller.clear();
                    setState(() {});
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Color(0xFF7C55E0), Color(0xFF4A2FA0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF7C55E0).withOpacity(0.35),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add_rounded, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Color(0xFF1E1830), height: 1, indent: 16, endIndent: 16),
          SizedBox(height: 4),

          // Notes list
          Expanded(
            child: box.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_stories_outlined,
                            color: Color(0xFF2A2040), size: 52),
                        SizedBox(height: 12),
                        Text(
                          "No notes yet",
                          style: TextStyle(
                              color: Color(0xFF3D3060),
                              fontSize: 14,
                              letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final item = box.getAt(index);
                      final text = item is Map ? item['text'] : item.toString();
                      final timeStr = item is Map ? item['time'] : null;
                      String subtitle = '';
                      if (timeStr != null) {
                        final dt = DateTime.parse(timeStr);
                        subtitle = DateFormat('MMM d, h:mm a').format(dt);
                      }
                      final accent = _accents[index % _accents.length];

                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF1A1626),
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            left: BorderSide(color: accent, width: 3),
                          ),
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          title: Text(
                            text,
                            style: TextStyle(
                                color: Color(0xFFD4B8FF),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: subtitle.isNotEmpty
                              ? Text(
                                  subtitle,
                                  style: TextStyle(
                                      color: Color(0xFF4A3F6B),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                )
                              : null,
                          trailing: GestureDetector(
                            onTap: () {
                              box.deleteAt(index);
                              setState(() {});
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE05564).withOpacity(0.1),
                              ),
                              child: Icon(Icons.delete_outline_rounded,
                                  color: Color(0xFFE05564), size: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}