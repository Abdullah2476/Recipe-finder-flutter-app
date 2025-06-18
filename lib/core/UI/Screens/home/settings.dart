import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipefinder/core/UI/Screens/auth/login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[400],
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Profile Section
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.deepOrange[100],
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.deepOrange[400],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? 'No Name',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user?.email ?? 'No Email',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add more sections here if needed
            SizedBox(height: 30),

            // Settings Options
            _buildSettingsSection(
              title: 'Preferences',
              icon: Icons.settings,
              children: [
                _buildSettingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _buildSettingsTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  trailing: Switch(value: false, onChanged: (val) {}),
                ),
                _buildSettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  trailing: Text(
                    'English',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            _buildSettingsSection(
              title: 'Account',
              icon: Icons.account_circle,
              children: [
                _buildSettingsTile(
                  icon: Icons.security,
                  title: 'Privacy & Security',
                  onTap: () {},
                ),
                _buildSettingsTile(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                _buildSettingsTile(
                  icon: Icons.info,
                  title: 'About App',
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 30),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _auth.signOut().then((value) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logged out successfully")),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.logout),
                label: Text('Log Out', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSettingsSection({
  required String title,
  required IconData icon,
  required List<Widget> children,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 8, bottom: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepOrange[400], size: 22),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown[800],
              ),
            ),
          ],
        ),
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(children: children),
      ),
    ],
  );
}

Widget _buildSettingsTile({
  required IconData icon,
  required String title,
  Widget? trailing,
  VoidCallback? onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.deepOrange[400]),
    title: Text(title),
    trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey),
    onTap: onTap,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
  );
}
