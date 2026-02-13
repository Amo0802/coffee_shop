import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  final VoidCallback? onClose;

  const ProfileSettingsPage({super.key, this.onClose});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _nameController = TextEditingController(text: 'Moa');
  final _emailController =
      TextEditingController(text: 'arminramusovic11@gmail.com');
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _handleClose() {
    if (widget.onClose != null) {
      widget.onClose!();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _saveName() {
    // TODO: Call backend to update name
    _showSnackBar('Name updated');
  }

  void _saveEmail() {
    // TODO: Call backend to update email
    _showSnackBar('Email updated');
  }

  void _savePassword() {
    if (_newPassController.text != _confirmPassController.text) {
      _showSnackBar('Passwords do not match');
      return;
    }
    // TODO: Call backend to update password
    _showSnackBar('Password updated');
    _currentPassController.clear();
    _newPassController.clear();
    _confirmPassController.clear();
  }

  void _logOut() {
    // TODO: Handle log out
  }

  void _deleteAccount() {
    // TODO: Handle delete account
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.black87,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6EDE4),
              Color(0xFFE8D9C8),
              Color(0xFFD2B8A3),
            ],
          ),
        ),
        child: Column(
          children: [
            // ── Header ──
            _buildHeader(topPadding),

            // ── Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: bottomPadding + 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Name section ──
                    _buildSectionLabel('Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _nameController,
                      hint: 'Your name',
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 12),
                    _buildSaveButton('Save Name', _saveName),

                    const SizedBox(height: 28),
                    _buildDivider(),
                    const SizedBox(height: 28),

                    // ── Email section ──
                    _buildSectionLabel('Email'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'Your email',
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _buildSaveButton('Save Email', _saveEmail),

                    const SizedBox(height: 28),
                    _buildDivider(),
                    const SizedBox(height: 28),

                    // ── Password section ──
                    _buildSectionLabel('Password'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _currentPassController,
                      hint: 'Current password',
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscureCurrent,
                      onToggleObscure: () =>
                          setState(() => _obscureCurrent = !_obscureCurrent),
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _newPassController,
                      hint: 'New password',
                      icon: Icons.lock_rounded,
                      obscure: _obscureNew,
                      onToggleObscure: () =>
                          setState(() => _obscureNew = !_obscureNew),
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _confirmPassController,
                      hint: 'Confirm new password',
                      icon: Icons.lock_rounded,
                      obscure: _obscureConfirm,
                      onToggleObscure: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                    const SizedBox(height: 12),
                    _buildSaveButton('Update Password', _savePassword),

                    const SizedBox(height: 40),
                    _buildDivider(),
                    const SizedBox(height: 32),

                    // ── Log out & Delete ──
                    Center(
                      child: GestureDetector(
                        onTap: _logOut,
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: _deleteAccount,
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Header ──────────────────────────────────────────────────

  Widget _buildHeader(double topPadding) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding + 14,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: _handleClose,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            ),
          ),
          const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Reusable Widgets ────────────────────────────────────────

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Colors.black.withValues(alpha: 0.4),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    final isPassword = onToggleObscure != null;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.7),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black.withValues(alpha: 0.25),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(icon, size: 20, color: Colors.black38),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onToggleObscure,
                  child: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: Colors.black38,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0),
            Colors.black.withValues(alpha: 0.08),
            Colors.black.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
