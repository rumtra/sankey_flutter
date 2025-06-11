// example/main.dart

import 'package:flutter/material.dart';
import 'package:sankey_flutter/sankey_helpers.dart';
import 'package:sankey_flutter/sankey_link.dart';
import 'package:sankey_flutter/sankey_node.dart';

/// The entry point of the Sankey Complex Example application
///
/// This function initializes the app by running [SankeyComplexExampleApp]
void main() {
  runApp(SankeyComplexExampleApp());
}

/// A stateless widget that defines the overall structure of the Sankey Diagram Example App
///
/// It sets the app title, theme, and uses a [Scaffold] to provide an app bar and a body
/// that renders the Sankey diagram
class SankeyComplexExampleApp extends StatelessWidget {
  const SankeyComplexExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex Sankey Diagram Example',
      home: Scaffold(
        appBar: AppBar(title: Text('Complex Sankey Diagram')),
        body: SankeyComplexDiagramWidget(),
      ),
    );
  }
}

/// A stateful widget that manages the interactive Sankey diagram
///
/// This widget builds a Sankey diagram using data defined in the [initState] method
/// It also handles user tap interactions to select nodes
class SankeyComplexDiagramWidget extends StatefulWidget {
  const SankeyComplexDiagramWidget({super.key});

  @override
  State<SankeyComplexDiagramWidget> createState() =>
      _SankeyComplexDiagramWidgetState();
}

/// The state class for [SankeyComplexDiagramWidget]
///
/// It defines the nodes, links, node colors, and handles layout computation and tap interactions
/// Changes in state trigger a repaint to reflect node selection and updates to the diagram
class _SankeyComplexDiagramWidgetState
    extends State<SankeyComplexDiagramWidget> {
  late List<SankeyNode> nodes;
  late List<SankeyLink> links;
  late Map<String, Color> nodeColors;
  late SankeyDataSet sankeyDataSet;
  TextSpan label(String text) {
    return TextSpan(
      children: [
        TextSpan(
          text: '$text\n',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: 'Tap to select',
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // Define the list of nodes across multiple layers
    nodes = [
      SankeyNode(id: 0, textSpan: label('Salary')),
      SankeyNode(id: 1, textSpan: label('Freelance')),
      SankeyNode(id: 2, textSpan: label('Investments')),
      SankeyNode(id: 3, textSpan: label('Total Income')),
      SankeyNode(id: 13, textSpan: label('Mandatory Expenses')),
      SankeyNode(id: 14, textSpan: label('Discretionary Expenses')),
      SankeyNode(id: 4, textSpan: label('Taxes')),
      SankeyNode(id: 5, textSpan: label('Essentials')),
      SankeyNode(id: 6, textSpan: label('Discretionary')),
      SankeyNode(id: 7, textSpan: label('Savings')),
      SankeyNode(id: 8, textSpan: label('Debt')),
      SankeyNode(id: 9, textSpan: label('Investments Reinvested')),
      SankeyNode(id: 10, textSpan: label('Healthcare')),
      SankeyNode(id: 11, textSpan: label('Education')),
      SankeyNode(id: 12, textSpan: label('Donations')),
    ];

    // Define the links between nodes with specified flow values
    links = [
      SankeyLink(source: nodes[0], target: nodes[3], value: 70),
      SankeyLink(source: nodes[1], target: nodes[3], value: 30),
      SankeyLink(source: nodes[2], target: nodes[3], value: 20),
      SankeyLink(source: nodes[3], target: nodes[13], value: 64),
      SankeyLink(source: nodes[3], target: nodes[14], value: 56),
      SankeyLink(source: nodes[13], target: nodes[4], value: 20),
      SankeyLink(source: nodes[13], target: nodes[5], value: 40),
      SankeyLink(source: nodes[13], target: nodes[10], value: 3),
      SankeyLink(source: nodes[13], target: nodes[11], value: 1),
      SankeyLink(source: nodes[14], target: nodes[6], value: 20),
      SankeyLink(source: nodes[14], target: nodes[7], value: 20),
      SankeyLink(source: nodes[14], target: nodes[8], value: 10),
      SankeyLink(source: nodes[14], target: nodes[9], value: 5),
      SankeyLink(source: nodes[14], target: nodes[12], value: 1),
    ];

    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.cyan,
      Colors.brown,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.grey,
      Colors.lime,
      Colors.amber,
      Colors.deepOrange,
    ];

    // Automatically generate a color map for the nodes using their labels
    nodeColors = generateDefaultNodeColorMap(nodes: nodes, colors: colors);

    // Combine the nodes and links into a data set
    sankeyDataSet = SankeyDataSet(nodes: nodes, links: links);

    // Generate the layout using a helper that configures the layout engine
    final sankey = generateSankeyLayout(
      width: 800,
      height: 500,
      nodeWidth: 20,
      nodePadding: 15,
    );
    sankeyDataSet.layout(sankey);
  }

  /// Callback for handling tap events on nodes
  ///
  /// When a node is tapped, its [id] is stored in [selectedNodeId],
  /// triggering a rebuild that highlights the node
  void _handleNodeTap(int? nodeId) {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: SankeyDiagramWidget(
          data: sankeyDataSet,
          nodeColors: nodeColors,
          onNodeTap: _handleNodeTap,
          showLabels: true,
        ),
      ),
    );
  }
}
