// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gradeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Future<void> _handleSignup() async {
    // 1. Validación básica: que las contraseñas coincidan
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden. Intenta de nuevo.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return; 
    }

    // 2. Activamos la ruedita de carga
    setState(() {
      _isLoading = true;
    });

    try {
      final supabase = Supabase.instance.client;

      // PASO MAGICO 1: Crear el usuario en auth
      final AuthResponse response = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final usuario = response.user;

      // PASO MAGICO 2: Guardamos sus datos en tu tabla 'perfiles'
      if (usuario != null) {
        await supabase.from('perfiles').insert({
          'id': usuario.id, 
          'nombre_completo': _nameController.text.trim(),  // ¡Corregido a _nameController!
          'cohorte': _gradeController.text.trim(),        // ¡Corregido a _gradeController!
        });

        // 3. Mensaje de éxito
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Registro exitoso! Bienvenido a Gestión CATEP.'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Opcional: Navegar hacia atrás (al Login) después del éxito
          // Navigator.pop(context); 
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al registrar: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDesktop ? Colors.white : const Color(0xFF0D3B6E),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  // ─── MOBILE LAYOUT ───────────────────────────────────────────────────────────
  Widget _buildMobileLayout() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildHeader(),
              ),
            ),
            const SizedBox(height: 50),
            _buildBottomCard(isDesktop: false),
          ],
        ),
      ),
    );
  }

  // ─── DESKTOP LAYOUT ──────────────────────────────────────────────────────────
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left panel — branding
        Expanded(
          flex: 5,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0D3B6E), Color(0xFF1565C0)],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogo(size: 100, imagePath: 'img/logo2_catep.png'),
                      const SizedBox(height: 28),
                      const Text(
                        'GESTIÓN CATEP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Sistema de Gestion de Actividades',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(width: 60, height: 2, color: Colors.white38),
                      const SizedBox(height: 40),
                      const Text(
                        'CATEP TURMERO',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Right panel — form
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.white,
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Crear cuenta',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0D3B6E),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Regístrate para acceder a tus actividades',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildForm(),
                          const SizedBox(height: 20),
                          _buildFooterLinks(),
                          const SizedBox(height: 40),
                          _buildVersionText(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── HEADER (Mobile) ─────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Column(
      children: [
        _buildLogo(size: 80),
        const SizedBox(height: 20),
       
      ],
    );
  }

  // ─── LOGO WIDGET ─────────────────────────────────────────────────────────────
  Widget _buildLogo({double size = 60, String imagePath = 'img/logo_catep.jpg'}) {
    return Container(
      width: size * 2.2,
      height: size,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  // ─── BOTTOM CARD (Mobile) ────────────────────────────────────────────────────
  Widget _buildBottomCard({required bool isDesktop}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0D3B6E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildForm(),
              const SizedBox(height: 20),
              _buildFooterLinks(),
              const SizedBox(height: 32),
              _buildVersionText(light: true),
            ],
          ),
        ),
      ),
    );
  }

  // ─── FORM ─────────────────────────────────────────────────────────────────────
  Widget _buildForm() {
    final bool isDark = _isDarkContext();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Name field
          _CatepTextField(
            controller: _nameController,
            hint: 'nombre y apellido',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.text,
            isDark: isDark,
          ),
          const SizedBox(height: 14),
         
          // Email field
          _CatepTextField(
            controller: _emailController,
            hint: 'correo@dominio.com',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            isDark: isDark,
          ),
          const SizedBox(height: 14),
          
          // cohorte field
          _CatepTextField(
            controller: _gradeController,
            hint: 'Indica tu cohorte',
            prefixIcon: Icons.school_outlined,
            keyboardType: TextInputType.text,
            isDark: isDark,
          ),
          const SizedBox(height: 14),
         
          // Password field
          _CatepTextField(
            controller: _passwordController,
            hint: 'contraseña',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            isDark: isDark,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: isDark ? Colors.white54 : const Color(0xFF6B7280),
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 14),

          // Confirm Password field
          _CatepTextField(
            controller: _confirmPasswordController,
            hint: 'confirmar contraseña',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            isDark: isDark,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: isDark ? Colors.white54 : const Color(0xFF6B7280),
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
          const SizedBox(height: 24),

          // Registrarse button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleSignup,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4D8),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF00B4D8).withValues(alpha: 0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── FOOTER LINKS ─────────────────────────────────────────────────────────────
  Widget _buildFooterLinks() {
    final bool isDark = _isDarkContext();
    return Column(
      children: [
        Divider(
          color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
          thickness: 1,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Ya tienes cuenta? ',
              style: TextStyle(
                color: isDark ? Colors.white60 : const Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Inicia sesión',
                style: TextStyle(
                  color: isDark
                      ? const Color(0xFF00B4D8)
                      : const Color(0xFF0D3B6E),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: isDark
                      ? const Color(0xFF00B4D8)
                      : const Color(0xFF0D3B6E),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVersionText({bool light = false}) {
    return Text(
      'Version 1.0 | 2025. CATEP TURMERO',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: light ? Colors.white30 : const Color(0xFFBBBBBB),
        fontSize: 11,
        letterSpacing: 0.5,
      ),
    );
  }

  bool _isDarkContext() {
    final size = MediaQuery.of(context).size;
    return size.width < 800;
  }
}

// ─── CUSTOM TEXT FIELD ────────────────────────────────────────────────────────
class _CatepTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final bool isDark;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const _CatepTextField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.isDark = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF1F2937),
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? Colors.white38 : const Color(0xFF9CA3AF),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDark ? Colors.white54 : const Color(0xFF6B7280),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDark
            ? Colors.white.withOpacity(0.08)
            : const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00B4D8), width: 1.8),
        ),
      ),
    );
  }
}