// lib\interactive_sankey_painter.dart

import 'package:flutter/material.dart';
import 'package:sankey_flutter/sankey_helpers.dart';
import 'package:sankey_flutter/sankey_link.dart';
import 'package:sankey_flutter/sankey_node.dart';
import 'package:sankey_flutter/sankey_painter.dart';

/// A [SankeyPainter] subclass that adds interactivity:
///
/// - Supports custom node colors per label
/// - Highlights connected links when a node is selected
/// - Applies hover/focus feedback with opacity and borders
class InteractiveSankeyPainter extends SankeyPainter {
  /// Map of node labels to specific colors
  final Map<String, Color> nodeColors;

  /// ID of the currently selected node, if any
  final int? selectedNodeId;
  final SankeyLink? selectedLink;

  const InteractiveSankeyPainter({
    required super.nodes,
    required super.links,
    required this.nodeColors,
    this.selectedNodeId,
    this.selectedLink,
    super.showLabels,
    super.linkColor,
    super.linkColorSource,
    super.linkOpacity,
    super.selectedLinkOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // --- Draw enhanced links ---
    for (SankeyLink link in links) {
      final source = link.source as SankeyNode;
      final target = link.target as SankeyNode;

      final sourceColor = nodeColors['${source.id}'] ?? Colors.blue;
      final targetColor = nodeColors['${target.id}'] ?? Colors.blue;

      final chosenColor = switch (linkColorSource) {
        LinkColorSource.source => sourceColor,
        LinkColorSource.target => targetColor,
      };

      // Highlight links connected to the selected node
      final isConnected =
          (selectedNodeId != null) &&
          (source.id == selectedNodeId || target.id == selectedNodeId);

      final linkSelected = selectedLink == link;
      final color = chosenColor.withValues(
        alpha: isConnected || linkSelected ? selectedLinkOpacity : linkOpacity,
      );

      final linkPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = link.width;

      final path = Path();
      final xMid = (source.x1 + target.x0) / 2;
      path.moveTo(source.x1, link.y0);
      path.cubicTo(xMid, link.y0, xMid, link.y1, target.x0, link.y1);

      canvas.drawPath(path, linkPaint);
    }

    // --- Draw colored nodes and labels with selection borders ---
    for (SankeyNode node in nodes) {
      final color = nodeColors['${node.id}'] ?? Colors.blue;
      final rect = Rect.fromLTWH(
        node.x0,
        node.y0,
        node.x1 - node.x0,
        node.y1 - node.y0,
      );
      final isSelected = selectedNodeId != null && node.id == selectedNodeId;

      canvas.drawRect(rect, Paint()..color = color);

      if (isSelected) {
        final borderPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawRect(rect, borderPaint);
      }

      if (node.textSpan != null && showLabels) {
        final textPainter = TextPainter(
          text: node.textSpan!,
          textDirection: TextDirection.ltr,
          textAlign: switch (_isRightmostNode(node)) {
            true => TextAlign.right,
            false => TextAlign.left,
          },
        );
        textPainter.layout(minWidth: 0, maxWidth: size.width);

        const margin = 4.0;
        final labelY = rect.top + (rect.height - textPainter.height) / 2;
        final labelOffsetRight = Offset(rect.right + margin, labelY);
        final labelOffsetLeft = Offset(
          rect.left - margin - textPainter.width,
          labelY,
        );

        // Automatically choose a side that fits within the canvas
        final fitsRight = rect.right + margin + textPainter.width <= size.width;
        final fitsLeft = rect.left - margin - textPainter.width >= 0;
        final isRightPreferred = fitsRight || !fitsLeft;

        final labelOffset = switch (isRightPreferred) {
          true => labelOffsetRight,
          false => labelOffsetLeft,
        };

        textPainter.paint(canvas, labelOffset);
      }
    }
  }

  bool _isRightmostNode(SankeyNode node) {
    final maxX1 = nodes.map((n) => n.x1).reduce((a, b) => a > b ? a : b);
    return node.x1 == maxX1;
  }

  @override
  bool shouldRepaint(covariant InteractiveSankeyPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.links != links ||
        oldDelegate.selectedNodeId != selectedNodeId ||
        oldDelegate.selectedLink != selectedLink;
  }
}
