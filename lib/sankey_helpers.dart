// lib/sankey_helpers.dart

import 'package:flutter/material.dart';
import 'package:sankey_flutter/interactive_sankey_painter.dart';
import 'package:sankey_flutter/sankey.dart';
import 'package:sankey_flutter/sankey_link.dart';
import 'package:sankey_flutter/sankey_node.dart';

/// Generates a configured [Sankey] layout engine
///
/// The [width] and [height] parameters define the drawing area dimensions
/// [nodeWidth] is the width of each node, and [nodePadding] sets the space between nodes
/// The returned [Sankey] object is pre-configured with the specified dimensions and
/// properties for use in computing the layout
///
/// Example:
/// ```dart
/// final sankey = generateSankeyLayout(
///   width: 1000,
///   height: 600,
///   nodeWidth: 20,
///   nodePadding: 15,
/// );
/// ```
Sankey generateSankeyLayout({
  double width = 1000,
  double height = 600,
  double nodeWidth = 20,
  double nodePadding = 15,
}) {
  return Sankey()
    ..nodeWidth = nodeWidth
    ..nodePadding = nodePadding
    ..x0 = 0
    ..y0 = 0
    ..x1 = width
    ..y1 = height;
}

/// Generates a default node color map for a list of [SankeyNode] objects
///
/// Each node's [label] is used to assign a color from [defaultNodeColors] in sequence
/// (cycling through the palette). This is useful as a convenience method when no
/// custom node colors are provided
///
/// Returns a [Map] with the node label as key and the assigned [Color] as value
Map<String, Color> generateDefaultNodeColorMap({
  required List<SankeyNode> nodes,
  required List<Color> colors,
}) {
  final Map<String, Color> colorMap = {};
  for (int i = 0; i < nodes.length; i++) {
    final id = '${nodes[i].id}';
    if (!colorMap.containsKey(id)) {
      colorMap[id] = colors[i % colors.length];
    }
  }
  return colorMap;
}

/// Determines if a tap hit a node and returns its [id]; returns null if no node is hit
///
/// [nodes] is the list of [SankeyNode] objects and [tapPos] is the [Offset] of
/// the tap event in the canvas coordinate space
int? detectTappedNode(List<SankeyNode> nodes, Offset tapPos) {
  for (var node in nodes) {
    final rect = Rect.fromLTWH(
      node.x0,
      node.y0,
      node.x1 - node.x0,
      node.y1 - node.y0,
    );
    if (rect.contains(tapPos)) return node.id;
  }
  return null;
}

/// Combines nodes and links with layout logic
///
/// The [SankeyDataSet] class holds the list of nodes and links, and provides a
/// [layout] method that applies the given [Sankey] layout generator to compute
/// the positions and dimensions for the nodes and links
class SankeyDataSet {
  final List<SankeyNode> nodes;
  final List<SankeyLink> links;

  const SankeyDataSet({required this.nodes, required this.links});

  /// Computes the layout for the nodes and links using the provided [sankey] generator.
  void layout(Sankey sankey) {
    sankey.layout(nodes, links);
  }
}

enum LinkColorSource { source, target }

/// A widget that wraps an interactive Sankey diagram
///
/// The [SankeyDiagramWidget] integrates gesture detection for tapping nodes and
/// renders the diagram using a [CustomPaint] widget. It takes a [SankeyDataSet] as
/// its data source, a node colors map, and an optional [selectedNodeId] along with a
/// callback [onNodeTap] which is called when a node is tapped
///
/// The [size] parameter specifies the drawing area for the diagram
class SankeyDiagramWidget extends StatefulWidget {
  final SankeyDataSet data;
  final Map<String, Color> nodeColors;
  final Function(int?)? onNodeTap;
  final Size size;
  final bool showLabels;
  final double linkOpacity;
  final LinkColorSource linkColorSource;

  const SankeyDiagramWidget({
    super.key,
    required this.data,
    required this.nodeColors,
    this.onNodeTap,
    this.size = const Size(1000, 600),
    this.showLabels = true,
    this.linkOpacity = 0.1,
    this.linkColorSource = LinkColorSource.source,
  });

  @override
  State<SankeyDiagramWidget> createState() => _SankeyDiagramWidgetState();
}

class _SankeyDiagramWidgetState extends State<SankeyDiagramWidget> {
  int? selectedNodeId;
  SankeyLink? selectedLink;

  void _handleNodeTap(int? nodeId) {
    setState(() {
      selectedNodeId = switch (selectedNodeId == nodeId) {
        true => null,
        false => nodeId,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        if (widget.onNodeTap == null) {
          return;
        }
        final tapped = detectTappedNode(
          widget.data.nodes,
          details.localPosition,
        );
        _handleNodeTap(tapped);
        widget.onNodeTap?.call(tapped);
      },
      child: CustomPaint(
        size: widget.size,
        painter: InteractiveSankeyPainter(
          nodes: widget.data.nodes,
          links: widget.data.links,
          nodeColors: widget.nodeColors,
          selectedNodeId: selectedNodeId,
          showLabels: widget.showLabels,
          linkColorSource: widget.linkColorSource,
          linkOpacity: widget.linkOpacity,
        ),
      ),
    );
  }
}
