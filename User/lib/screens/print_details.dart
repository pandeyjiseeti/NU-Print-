import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:User/const.dart';
import 'package:User/screens/payment.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrintDetails extends StatefulWidget {
  @override
  _PrintDetailsState createState() => _PrintDetailsState();
}

class _PrintDetailsState extends State<PrintDetails> {
  bool _isBlackWhite = false;
  bool _isColor = false;
  int _noOfCopies = 1;
  bool _isTwoSide = false;
  bool _isoneSide = false;
  bool _isMultiFile = false;
  List<String> attachmentURL = [];
  List<File> _fileList;
  Map<String, dynamic> errorMap = {};
  final _fileType = FileType.custom;
  final List<String> _allowedExtensions = [
    'jpg',
    'pdf',
    'doc',
    'jpeg',
    'docx',
    'psd',
    'png',
    'xlsx',
    'ppt',
    'rtf',
    'odt',
    'txt',
    'pptx'
  ];
  Map<String, dynamic> _printDetails = {};
  int _noOfColorPages = 0;
  int _noOfBWPages = 0;

  _getFile() async {
    if (_isMultiFile) {
      _fileList = await FilePicker.getMultiFile(
          allowedExtensions: _allowedExtensions, type: _fileType);
    } else
      _fileList = [
        await FilePicker.getFile(
            allowedExtensions: _allowedExtensions, type: _fileType),
      ];
  }

  Map<String, dynamic> _validation() {
    String _errorMessage;
    bool _isError;
    if (_isBlackWhite == false && _isColor == false)
      _errorMessage =
          'No Page Color Type Selected. Please select one to proceed.';
    else if (_isoneSide == false && _isTwoSide == false)
      _errorMessage = 'No Page Side Selected. Please select one to proceed.';
    else if (_noOfBWPages == 0 && _noOfColorPages == 0)
      _errorMessage = '0 amount of Pages. Please select one to proceed';
    else if (attachmentURL.length == 0)
      _errorMessage = 'No file selected. Please select one to proceed.';

    _isError = _errorMessage != null;
    return {
      'errorMessage': _errorMessage,
      'isError': _isError,
    };
  }

  _buildBottomSheet(BuildContext context) async {
    return (await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (context) {
        return _fileList[0] == null
            ? Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(child: Text('No file Selected...')),
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: _fileList.length,
                        itemBuilder: (context, index) {
                          attachmentURL.add(
                            _fileList[index].path,
                          );
                          return Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: ListTile(
                              title: Text(
                                  path.basenameWithoutExtension(
                                      _fileList[index].path),
                                  style: TextStyle()),
                              subtitle: Text(_fileList[index].path),
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[100],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: IconButton(
                              color: Colors.white,
                              icon: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'CONFIRM',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    size: 25.0,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                errorMap.addAll(_validation());
                                if (errorMap['isError']) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: 'ERROR : ' +
                                          errorMap['errorMessage']);
                                } else {
                                  _printDetails.addAll({
                                    'No_of_Copies': _noOfCopies,
                                    'No_of_BW_Pages': _noOfBWPages,
                                    'No_of_Color_Pages': _noOfColorPages,
                                    'Page_Side': _isTwoSide,
                                    'attachment_URL': attachmentURL.toSet().toList()
                                  });
                                  print(_printDetails.toString());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Payment(_printDetails),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ))
                  ],
                ),
              );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.blueAccent[100],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 15.0),
              child: Text(
                'Print Details',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Page Color Type',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Constants.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Transform.scale(
                                scale: 1.5,
                                child: FilterChip(
                                  label: Text('B/W'),
                                  labelStyle: TextStyle(
                                      color: _isBlackWhite
                                          ? Colors.black
                                          : Colors.white),
                                  selected: _isBlackWhite,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isBlackWhite = !_isBlackWhite;
                                    });
                                  },
                                  selectedColor: Theme.of(context).accentColor,
                                  checkmarkColor: Colors.black,
                                ),
                              ),
                              Transform.scale(
                                scale: 1.5,
                                child: FilterChip(
                                  label: Text('Color'),
                                  labelStyle: TextStyle(
                                      color: _isColor
                                          ? Colors.black
                                          : Colors.white),
                                  selected: _isColor,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isColor = !_isColor;
                                    });
                                  },
                                  selectedColor: Theme.of(context).accentColor,
                                  checkmarkColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: ListTile(
                        title: Text(
                          'Number of Copies',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Constants.textPrimary,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              _noOfCopies += 1;
                            });
                          },
                          onDoubleTap: () {
                            setState(() {
                              if (_noOfCopies > 0) {
                                _noOfCopies -= 1;
                              }
                            });
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                _noOfCopies.toString(),
                                style: TextStyle(
                                    fontSize: 30.0, color: Colors.white),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent[100],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _isBlackWhite
                      ? Card(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ListTile(
                              title: Text(
                                'Black & White Pages',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Constants.textPrimary,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _noOfBWPages += 1;
                                  });
                                },
                                onDoubleTap: () {
                                  setState(() {
                                    if (_noOfBWPages > 0) {
                                      _noOfBWPages -= 1;
                                    }
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      _noOfBWPages.toString(),
                                      style: TextStyle(
                                          fontSize: 30.0, color: Colors.white),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent[100],
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  _isColor
                      ? Card(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ListTile(
                              title: Text(
                                'Color Pages',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Constants.textPrimary,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _noOfColorPages += 1;
                                  });
                                },
                                onDoubleTap: () {
                                  setState(() {
                                    if (_noOfColorPages > 0) {
                                      _noOfColorPages -= 1;
                                    }
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      _noOfColorPages.toString(),
                                      style: TextStyle(
                                          fontSize: 30.0, color: Colors.white),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent[100],
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Page Side',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Constants.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Transform.scale(
                                scale: 1.5,
                                child: FilterChip(
                                  label: Text('One-Side'),
                                  labelStyle: TextStyle(
                                      color: _isoneSide
                                          ? Colors.black
                                          : Colors.white),
                                  selected: _isoneSide,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isoneSide = !_isoneSide;
                                      _isTwoSide = !_isoneSide;
                                    });
                                  },
                                  selectedColor: Theme.of(context).accentColor,
                                  checkmarkColor: Colors.black,
                                ),
                              ),
                              Transform.scale(
                                scale: 1.5,
                                child: FilterChip(
                                  label: Text('Two-Side'),
                                  labelStyle: TextStyle(
                                      color: _isTwoSide
                                          ? Colors.black
                                          : Colors.white),
                                  selected: _isTwoSide,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _isTwoSide = !_isTwoSide;
                                      _isoneSide = !_isTwoSide;
                                    });
                                  },
                                  selectedColor: Theme.of(context).accentColor,
                                  checkmarkColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.16,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: RaisedButton(
                          onPressed: () async {
                            await _getFile();
                            await _buildBottomSheet(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(69, 127, 202, 1),
                                    Color.fromRGBO(97, 144, 232, 1)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(35.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6,
                                  minHeight:
                                      MediaQuery.of(context).size.width * 0.16),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.file_upload,
                                      color: Color.fromRGBO(97, 144, 232, 1),
                                    ),
                                    height: MediaQuery.of(context).size.width *
                                        0.155,
                                    width: MediaQuery.of(context).size.width *
                                        0.155,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Get Multiple Files',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.02,
                      ),
                      CupertinoSwitch(
                        activeColor: Colors.green,
                        trackColor: Colors.blue[500],
                        value: _isMultiFile,
                        onChanged: (val) {
                          setState(() {
                            _isMultiFile = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
