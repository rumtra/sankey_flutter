// lib/sankey_link.dart

import 'sankey_node.dart';

/// A link (flow) between two nodes in the Sankey diagram.
class SankeyLink {
  dynamic source; // Resolved SankeyNode
  dynamic target; // Resolved SankeyNode
  double value;
  int index = 0;
  double y0 = 0.0; // Vertical start position at source
  double y1 = 0.0; // Vertical end position at target
  double width = 0.0; // Proportional width of the link

  SankeyLink({required this.source, required this.target, required this.value});
}

