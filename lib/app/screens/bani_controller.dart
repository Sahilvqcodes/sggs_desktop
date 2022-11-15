import 'package:flutter/material.dart';
import 'package:gurugranth_app/app/screens/drawer.dart';

class BaniController extends StatelessWidget {
  BaniController({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      // resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/background.png"),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          scale: 6,
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Text(
                          "Take Control of SGGS",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const Text(
                          "Control SGGS on your computer using your mobile device. Sit anywhere in the Darbar Hall with the sangat or Keertani while still being able to control SGGS. Bani Controller adds more flexibility and mobility to project Gurbani on to the big screen.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                              height: 1.25,
                              color: Color(0xFF3D3D3D)),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter code. Eg. ABC-XYZ',
                                  // prefixIcon: Icon(Icons.mail_outline),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 1.5),
                                  ),
                                ),
                                // controller: _emailController,
                                onChanged: (value) {
                                  // user.email = value;
                                },
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value!.isEmpty)
                                      ? 'Please enter code'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter PIN EG. 1234',
                                  // prefixIcon: Icon(Icons.mail_outline),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 1.5),
                                  ),
                                ),
                                // controller: _emailController,
                                onChanged: (value) {
                                  // user.email = value;
                                },
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value!.isEmpty)
                                      ? 'Please enter pin'
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                              ),
                              Container(
                                width: size.width * 0.6,
                                height: size.height * 0.06,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // if (_key.currentState!.validate()) {
                                    //   onLoginTap();
                                    // }
                                  },
                                  child: const Text(
                                    "Connect to Desktop",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Theme.of(context).colorScheme.primary),
                  child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
