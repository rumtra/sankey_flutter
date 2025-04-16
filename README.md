# Sankey Flutter

**Version:** 0.0.1

Sankey Flutter is a Flutter package for rendering beautiful and interactive Sankey diagrams. This package adapts the proven [d3-sankey](https://github.com/d3/d3-sankey) layout algorithm into Dart, so you can generate complex node-link diagrams with customizability and high performance directly in your Flutter apps.

## Features

- **Dynamic Layout:** Automatically compute node and link positions.
- **Customizable Appearance:** Adjust node width, padding, alignment options, and theming.
- **Smooth Curved Links:** Render links using cubic Bézier curves similar to d3's horizontal link shape.
- **Interactivity:** Easily extendible for adding tap, hover, or animation effects.
- **Open Source:** Fully available for modification and extension.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  sankey_flutter: ^0.0.1
```

Then, run:

```bash
flutter pub get
```

## Usage
See the example for a full working sample. Here’s a quick snippet to render a basic Sankey diagram:

```bash
import 'package:flutter/material.dart';
import 'package:sankey_flutter/sankey.dart';
import 'package:sankey_flutter/sankey_node.dart';
import 'package:sankey_flutter/sankey_link.dart';
import 'package:sankey_flutter/sankey_painter.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Sankey Diagram Example')),
      body: Center(
        child: CustomPaint(
          size: Size(400, 400),
          painter: SankeyPainter(
            nodes: nodes, // List of [SankeyNode] objects.
            links: links, // List of [SankeyLink] objects.
          ),
        ),
      ),
    ),
  ));
}
```

For a complete working example with interactivity and layout computation, please refer to `example/main.dart`.

## Documentation
For detailed API documentation, please review the inline comments in the source code and visit the package page on pub.dev.

## Contributing
Contributions are welcome! Please review our `CONTRIBUTING.md` file for more details on how to get started, including testing procedures and coding standards.

## License
This project is licensed under the `BSD-3-Clause` License.

---

## CONTRIBUTING.md

```markdown
### Contributing to Sankey Flutter

Thank you for your interest in contributing to Sankey Flutter! Your contributions help improve the package and benefit the entire Flutter community. 

d3-sankey Compatibility: The package strives to closely mirror the output of d3-sankey to ensure familiarity and reliability.

Collaboration: We welcome all contributions—from code improvements to documentation fixes. Your help is appreciated in making this package production-grade!

#### Golden Tests and Layout Tolerance

This package uses fuzzy golden tests to validate the fidelity of the Sankey layout. The tests are designed to be resilient to minor floating-point differences.

- **Fuzzy Golden Tests:** Tests compare computed node/link positions against known-good outputs (e.g., from [d3-sankey](https://github.com/d3/d3-sankey)).
- **Tolerance:** Position values (`x`, `y`, `dx`, `dy`, `sy`, `ty`) are compared with a tolerance of ±1.0 units (or as set in the tests) to account for minor differences from floating-point rounding, layout relaxation, or iteration order.
```

## Getting Started
* Fork the Repository: Start by forking the project on GitHub.
* Clone Your Fork: Clone the fork locally and set up your development environment.
* Run the Tests: Make sure all tests pass by running:
* Submit Pull Requests: Follow the guidelines and submit your changes via pull requests.

Thank you for contributing to Sankey Flutter!