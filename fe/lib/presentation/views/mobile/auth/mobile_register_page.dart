import 'package:fe/main.dart';
import 'package:flutter/material.dart';

class MobileRegisterPage extends StatelessWidget {
  const MobileRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Abu-abu Muda
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo Aplikasi
              const Icon(
                Icons.person_add, // Ikon untuk register
                size: 100,
                color: Color(0xFF0D47A1), // Biru Tua
              ),
              const SizedBox(height: 16.0),
              // Judul & Sub-judul
              const Text(
                'Daftar Akun Baru',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Bergabunglah dengan Blog Magang IKP DISKOMINFOTIK NTB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF757575), // Abu-abu Sedang
                ),
              ),
              const SizedBox(height: 48.0),
              // Formulir Nama Lengkap
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xFF0D47A1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              // Formulir Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              // Formulir Password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF0D47A1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24.0),
              // Tombol Daftar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika register akan ditambahkan di sini nanti
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3), // Biru Cerah
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Tautan ke Halaman Login (dengan animasi)
              TextButton(
                onPressed: () {
                  // Navigasi kembali ke halaman login dengan transisi kustom
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MyApp(), // Pastikan nama kelas login page benar
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Geser dari kanan
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: const Text(
                  'Sudah punya akun? Masuk di sini',
                  style: TextStyle(color: Color(0xFF0D47A1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
