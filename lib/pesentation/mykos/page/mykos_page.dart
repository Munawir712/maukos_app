import 'package:flutter/material.dart';
import 'package:maukos_app/core/constant/constants.dart';
import 'package:maukos_app/core/themes/color.dart';
import 'package:maukos_app/core/themes/textstyle.dart';

class MyKosPage extends StatefulWidget {
  const MyKosPage({Key? key}) : super(key: key);

  @override
  State<MyKosPage> createState() => _MyKosPageState();
}

class _MyKosPageState extends State<MyKosPage> {
  bool hasSewa = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kos Saya',
          style: textStyle.copyWith(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "Kos yang sedang kamu sewa saat ini",
                style: textStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (hasSewa) ...[
              const KosSewaCard(),
            ] else ...[
              Center(
                child: Column(
                  children: [
                    Text(
                      "Kamu Belum Menyewa Kos",
                      style: textStyle.copyWith(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: secondColor, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text(
                          'Cari Kos',
                          style: textStyle.copyWith(
                            color: secondColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class KosSewaCard extends StatelessWidget {
  const KosSewaCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.2),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Putra",
                  style: textStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 186,
                child: Text(
                  "Kos Putra Tipe A ",
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.copyWith(),
                ),
              ),
              Text(
                "Banda Aceh",
                style: textStyle.copyWith(fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Lihat Selengkapnya",
                  style: textStyle.copyWith(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w300,
                    color: secondColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
