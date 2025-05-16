## [0.0.2] - Add `showLabels` Toggle for Node Labels

### ✨ New Features
- Added `showLabels` boolean parameter to `InteractiveSankeyPainter` to enable or disable node label rendering.
- Exposed `showLabels` parameter through `buildInteractiveSankeyPainter()` and `SankeyDiagramWidget`, allowing label control at the widget level.
- Added example usage demonstrating label toggle support.

### 🛠 Enhancements
- Label rendering logic now respects the `showLabels` flag during painting.
- Improved flexibility for use cases where minimal or uncluttered visuals are preferred.

Thanks to [@pese-git](https://github.com/pese-git) for the contribution!

---

## [0.0.1] - Initial Release

- Fully featured Sankey layout engine adapted from d3-sankey
- Supports customizable node width, padding, alignment, and interactivity
- Includes test fixture parity with d3's energy example
