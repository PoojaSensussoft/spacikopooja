import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spacikopooja/utils/Utility.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


class PoojaVerifyOTP extends StatefulWidget {
  @override
  _PoojaVerifyOTPState createState() => _PoojaVerifyOTPState();
}

class _PoojaVerifyOTPState extends State<PoojaVerifyOTP> with SingleTickerProviderStateMixin {
  final int time = 30;
  AnimationController _controller;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  @override
  void initState() {
    super.initState();

    totalTimeInSeconds = time;
    _controller = AnimationController(vsync: this, duration: Duration(seconds: time))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            _hideResendButton = !_hideResendButton;
          });
        }
      });
    _controller.reverse(from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,

      appBar: _appBar,

      body: Container(
        width: MediaQuery.of(context).size.width,
        color: spacikoColor.Colorlihgt_green,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: [
            _getVerificationCodeLabel,
            SizedBox(height: 20),

            _getEmailLabel,
            SizedBox(height: 40),

            _getInputField,

            _hideResendButton ? _getTimerText : _getResendButton,

            SizedBox(height: 20),

            _getOtpButton,
          ],
        ),
      ),
    );
  }

  get _appBar{
    return AppBar(
      backgroundColor: spacikoColor.Colorlihgt_green,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_sharp, color: spacikoColor.Colorblack),
        iconSize: 20,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  get _getVerificationCodeLabel {
    return Flexible(
      child: Text(
        "Verification Code",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, color: spacikoColor.Colorblack, fontFamily: 'poppins_semibold')),
    );
  }

  get _getEmailLabel {
    return Flexible(
      child: Text(
        "Please enter the OTP sent\non your registered Email ID.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0, color: spacikoColor.Colorblack, fontFamily: 'poppins_regular')),
    );
  }

  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(true, false),
        _otpTextField(false, false),
        _otpTextField(false, false),
        _otpTextField(false, true),
      ],
    );
  }

  Widget _otpTextField(bool first, bool last) {
    return Container(
      width: 60,
      height: 100,

      child: AspectRatio(
        aspectRatio: 1.0,

        child: TextField(
          cursorColor: spacikoColor.ColorPrimary,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }

            if (value.length == 1 && last == true) {
              FocusScope.of(context).unfocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,

          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: spacikoColor.ColorOpacity),
                borderRadius: BorderRadius.circular(10)),

            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.5, color: spacikoColor.ColorPrimary),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }


  get _getTimerText{
    return Container(
      height: 32,

      child: Offstage(
        offstage: !_hideResendButton,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.access_time),
            SizedBox(width: 5.0),
            OtpTimer(_controller, 15.0, Colors.black)
          ],
        ),
      ),
    );
  }

  get _getResendButton {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: Text("Resend Otp", style: TextStyle(fontWeight: FontWeight.bold, color: spacikoColor.Colorblack,
            fontSize: 16),
        ),
      ),

      onTap: () {
        setState(() {
          Utility.showToast("Resend OTP");
          _startCountdown();
        });
      },
    );
  }

  get _getOtpButton {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 40,

      child: RaisedButton(
        color: spacikoColor.ColorPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text('Verify', style: TextStyle(fontSize: 18, color: spacikoColor.Colorwhite)),

        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

}


class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }

}