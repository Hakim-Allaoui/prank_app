import 'package:flutter/material.dart';
import 'package:prank_app/utils/strings.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';

class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        _stars >= starCount ? Icons.star : Icons.star_border,
         size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        print(starCount);
        if (starCount >= 4) {
          Navigator.pop(context);
          Tools.launchURLRate();
        }
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  child: Image.asset('assets/icon.png'),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                    child: Text(
                      Tools.packageInfo.appName,
                      style: MyTextStyles.bigTitleBold,
                    ))
              ],
            ),
            SizedBox(height: 20.0,),
            Text(Strings.aboutText, textAlign: TextAlign.center, style: MyTextStyles.subTitle,),
            Text('👇 Please Rate Us 👇', textAlign: TextAlign.center, style: MyTextStyles.subTitle,),
          ],
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop(0);
          },
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_stars);
          },
        )
      ],
    );
  }
}