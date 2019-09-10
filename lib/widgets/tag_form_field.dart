import 'package:flutter/material.dart';

class TagFormField extends StatefulWidget {
  final void Function(List<String>) onTagsUpdated;
  final String label;

  TagFormField({Key key, this.onTagsUpdated, this.label}) : super(key: key);

  @override
  _TagFormFieldState createState() => _TagFormFieldState();
}

class _TagFormFieldState extends State<TagFormField> {
  List<String> tags = [];
  TextEditingController _controller = TextEditingController();
  
  @override
  initState() {
    _controller.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    _children.add(
      TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: false,
          labelText: widget.label ?? "Tags",
          suffixIcon: _controller.text == "" ? null : IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              setState(() {
                if(!tags.contains(_controller.text)) {
                  tags.add(_controller.text);
                  widget.onTagsUpdated(tags);
                }

                _controller.clear();

                FocusScope.of(context).unfocus();
              });
            },
          ),
        ),
      ),
    );

    if(tags.length > 0) {
      _children.addAll([
        SizedBox(height: 5),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 5,
          children: List.generate(tags.length, (i) {
            return Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
                //border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.ideographic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tags[i],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tags.removeAt(i);
                        widget.onTagsUpdated(tags);
                      });
                    },
                    child: Icon(Icons.clear, size: 18),
                  )
                ],
              ),
            );
          }),
        ),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _children,
    );
  }
}