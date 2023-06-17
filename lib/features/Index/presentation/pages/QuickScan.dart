import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/widgetFuntions.dart';
import '../../../../core/services/api.dart';
import 'Dashboard.dart';

class QuickScan extends StatefulWidget {
  const QuickScan({super.key});

  @override
  State<QuickScan> createState() => _QuickScanState();
}

final addressController = TextEditingController();
bool? success = false;
bool? loading = false;
bool? suspicious = false;
bool? unsafe = false;
bool? phishing = false;
bool? malware = false;
bool? adult = false;
dynamic message;
dynamic ipaddress;
dynamic domain;
dynamic dnsValid;
int? domainRank;
dynamic spamming;
dynamic safe;

class _QuickScanState extends State<QuickScan> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: normalAppBar(context, title: 'Quick Scan', isFromDashboard: true),
      body: screenBody(
        context,
        children: [
          emphasisText(
            'Enter the URL of the website you want to scan below:',
            fontWeight: FontWeight.w600,
            size: 16,
          ),
          addVertical(15),
          buildTextField(
            'Enter URL here',
            'eg: www.google.com',
            false,
            false,
            addressController,
          ),
          addVertical(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: SizedBox(
              height: 50,
              width: size.width * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: warning,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {

                  dynamic result = await Api().scan(addressController.text);

                  print(result);

                  setState(() {
                    loading = true;
                    success = result['success'];
                    message = result['message'];
                    dnsValid = result['dns_valid'];
                    domain = result['domain'];
                    ipaddress = result['ip_address'];
                    spamming = result['spamming'];
                    suspicious = result['suspicious'];
                    unsafe = result['unsafe'];
                    phishing = result['phishing'];
                    domainRank = result['domain_rank'];
                    malware = result['malware'];
                    safe = result['unsafe'];
                    allCount += 1;
                  });
                  if (result['phishing'] == true) {
                    phishingCount += 1;
                  }
                  if (result['suspicious'] == true) {
                    susCount += 1;
                  }
                  if (result['unsafe'] != false) {
                    safeCount += 1;
                  }
                  if (result['malware'] == true) {
                    malwareCount += 1;
                  }
                  if (result['dns_valid'] == true) {
                    dnsCount += 1;
                  }
                  loading = false;
                },
                child: subText('Scan Now', size: 16),
              ),
            ),
          ),
          addVertical(25),
          Center(child: emphasisText('Scan Results', fontWeight: FontWeight.w600, size: 16)),
          addVertical(15),
          Row(
            children: [
              emphasisText('Outcome: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                success == false ? "Failed" : "Successful",
                color: success == true ? successful[400] : error[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              emphasisText('Message: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              Expanded(
                child: subTextRaleway(
                  // message,
                  message ?? "No message",
                  color: message != null ? successful[400] : error[400],
                  size: 16,
                ),
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('DNS Valid: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                dnsValid == false ? "False" : "True",
                color: dnsValid == false ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Spamming: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                spamming == true ? "True" : "False",
                color: spamming == true ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Suspicious: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                suspicious == true ? "True" : "False",
                color: suspicious == true ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('IP Address: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                ipaddress ?? "No available IP Address!",
                color: message != null ? successful[400] : error[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Domain Rank: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                domainRank == null ? "No domain scanned!" : domainRank.toString(),
                color: successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Phishing: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                phishing == true ? "True" : "False",
                color: phishing == true ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Malware: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                malware == true ? "True" : "False",
                color: malware == true ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Adult Content: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                adult == true ? "True" : "False",
                color: adult == true ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
          Row(
            children: [
              emphasisText('Safe Scan: ', fontWeight: FontWeight.w600, size: 16),
              addHorizontal(10),
              subTextRaleway(
                safe == false ? "True" : "False",
                color: safe == true ? error[400] : successful[400],
                size: 16,
              ),
            ],
          ),
          addVertical(15),
        ],
      ),
    );
  }
}
