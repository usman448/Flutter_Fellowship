import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _compactCards = false;
  bool _cookingNotifications = true;
  bool _autoSync = false;
  String _defaultCategory = 'Lunch';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final compact = await PreferencesService.loadCompactCards();
    final notifs = await PreferencesService.loadNotifications();
    final defCat = await PreferencesService.loadDefaultCategory();
    setState(() {
      _compactCards = compact;
      _cookingNotifications = notifs;
      _defaultCategory = defCat;
    });
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: kCardDark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: kPrimaryColor,
      ),
    );
  }

  Widget _buildArrowTile({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance
            _buildSection('Appearance', [
              _buildSwitchTile(
                icon: Icons.dark_mode,
                iconBg: kPrimaryColor,
                title: 'Dark Theme',
                subtitle: widget.isDarkMode
                    ? 'Currently using dark mode'
                    : 'Currently using light mode',
                value: widget.isDarkMode,
                onChanged: widget.onThemeToggle,
              ),
              const Divider(height: 1, indent: 70),
              _buildSwitchTile(
                icon: Icons.grid_view,
                iconBg: kPrimaryColor,
                title: 'Compact Cards',
                subtitle: 'Use smaller cards to show more content',
                value: _compactCards,
                onChanged: (v) => setState(() => _compactCards = v),
              ),
            ]),

            // Preferences
            _buildSection('Preferences', [
              _buildArrowTile(
                icon: Icons.restaurant,
                iconBg: kPrimaryColor,
                title: 'Default Category',
                subtitle: 'New recipes will default to $_defaultCategory',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      value: _defaultCategory,
                      underline: const SizedBox(),
                      dropdownColor: kCardDark,
                      style: TextStyle(fontSize: 13, color: kPrimaryColor),
                      items: kCategories
                          .where((c) => c != 'All')
                          .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)),
                          )
                          .toList(),
                      onChanged: (v) {
                        // ← updated
                        setState(() => _defaultCategory = v!);
                        PreferencesService.saveDefaultCategory(v!);
                      },
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
              const Divider(height: 1, indent: 70),
              _buildSwitchTile(
                icon: Icons.notifications,
                iconBg: kPrimaryColor,
                title: 'Cooking Notifications',
                subtitle: 'Get reminders for cooking times',
                value: _cookingNotifications,
                onChanged: (v) {
                  // ← updated
                  setState(() => _cookingNotifications = v);
                  PreferencesService.saveNotifications(v);
                },
              ),
              const Divider(height: 1, indent: 70),
              _buildSwitchTile(
                icon: Icons.sync,
                iconBg: kPrimaryColor,
                title: 'Auto Sync',
                subtitle: 'Automatically sync recipes across devices',
                value: _autoSync,
                onChanged: (v) =>
                    setState(() => _autoSync = v), // ye same rahega
              ),
            ]),

            // Data
            _buildSection('Data', [
              _buildArrowTile(
                icon: Icons.download,
                iconBg: kPrimaryColor,
                title: 'Export Recipes',
                subtitle: 'Save your recipes as a backup file',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 70),
              _buildArrowTile(
                icon: Icons.delete_outline,
                iconBg: Colors.red.shade700,
                title: 'Clear Cache',
                subtitle: 'Free up storage space',
                onTap: () {},
              ),
            ]),

            // About
            _buildSection('About', [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.restaurant_menu,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: const Text(
                  'CookBook',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Version 1.0.0\nDeveloped by Usman',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const Divider(height: 1, indent: 70),
              _buildArrowTile(
                icon: Icons.help_outline,
                iconBg: kPrimaryColor,
                title: 'Help & Support',
                subtitle: 'Get help with using the app',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 70),
              _buildArrowTile(
                icon: Icons.star_outline,
                iconBg: kPrimaryColor,
                title: 'Rate App',
                subtitle: 'Rate us on the App Store',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 70),
              _buildArrowTile(
                icon: Icons.privacy_tip_outlined,
                iconBg: kPrimaryColor,
                title: 'Privacy Policy',
                subtitle: 'Review our privacy practices',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
