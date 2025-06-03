import 'package:flutter/material.dart';
import 'package:pharmes_app/modules/sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  bool _obscureLoginPassword = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: DiagonalClipper(),
                      child: Container(
                        height: 300,
                        color: const Color(0xFF245FD5),
                        child: Align(
                          alignment: const Alignment(-0.3, -0.3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.jpg',
                                height: 75,
                                width: 75,
                              ),
                              const Text(
                                'PharMES',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                TabBar(
                                  controller: _tabController,
                                  labelColor: const Color(0xFF1E62F2),
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  indicatorColor: const Color(0xFF1E62F2),
                                  indicatorWeight: 2,
                                  tabs: const [
                                    Tab(text: 'Sign in'),
                                    Tab(text: 'Sign Up'),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: _tabController.index == 0 ? 300 : 428,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      // Sign in
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF1F1F1),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: TextField(
                                              controller: loginEmailController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.email, size: 20, color: Colors.grey[700]),
                                                hintText: "Enter your Email",
                                                hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                                                border: InputBorder.none,
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          const Text(
                                            'Password',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF1F1F1),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: TextFormField(
                                              obscureText: _obscureLoginPassword,
                                              controller: loginPasswordController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.lock, size: 20, color: Colors.grey[700]),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _obscureLoginPassword ? Icons.visibility_off : Icons.visibility,
                                                    color: Colors.grey[700],
                                                    size: 22,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscureLoginPassword = !_obscureLoginPassword;
                                                    });
                                                  },
                                                ),
                                                hintText: "Password",
                                                hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                                                border: InputBorder.none,
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'Forget Password?',
                                                style: TextStyle(
                                                  color: Color(0xFF245FD5),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 45,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF245FD5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                              ),
                                              child: const Text(
                                                'Sign In',
                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Sign Up
                                       SignUpScreen(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width - 260, size.height - 80,
        size.width - 34, size.height - 35);
    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
