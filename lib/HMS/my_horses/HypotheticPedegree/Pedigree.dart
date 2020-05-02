import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
class HypotheticalPedigree extends StatefulWidget {
  var horseData;

  HypotheticalPedigree(this.horseData);

  @override
  _HypotheticalPedigreeState createState() => _HypotheticalPedigreeState(horseData);
}
class _HypotheticalPedigreeState extends State<HypotheticalPedigree> {
  TreeViewController controller;List<Node> nodes;
  var horseData;

  _HypotheticalPedigreeState(this.horseData);

  @override
  void initState() {
    setState(() {
      nodes=[
        Node(
            label: horseData['name'],
            key: 'hn',
            children: [
              Node(
                  label: horseData['sireName']!=null?horseData['sireName']['name']:'',
                  key:'sn'
              ),
              Node(
                  label: horseData['damName']!=null?horseData['damName']['name']:'',
                  key: 'dm'
              ),
            ]

        ),
      ];
      controller=TreeViewController(
        children: nodes
      );

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedigree"),),
      body: Container(
        color: Colors.transparent,
        child: TreeView(
          controller: controller,
          allowParentSelect: true,
        ),
      ),
    );
  }
}
