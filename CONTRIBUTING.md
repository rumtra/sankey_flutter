## 🧪 Golden Tests and Layout Tolerance

This package uses fuzzy golden tests to validate Sankey layout fidelity.

- Tests compare computed node/link positions against known-good layouts (e.g., from `d3-sankey`).
- Position values (`x`, `y`, `dx`, `dy`, `sy`, `ty`) are compared using a tolerance of ±1.0 units.
- This accounts for minor differences between Dart and JavaScript float rounding, layout relaxation, or iteration order.

### How to Contribute Test Fixtures

You may:
- Add `.json` fixtures in `test/`
- Use `CustomPaint` to visually verify alignment
- Run tests with `flutter test` to confirm consistency

To regenerate reference outputs:
```dart
// In test or dev tools
File('test/energy_nodes.generated.json').writeAsStringSync(JsonEncoder.withIndent('  ').convert(actualNodes));
File('test/energy_links.generated.json').writeAsStringSync(JsonEncoder.withIndent('  ').convert(actualLinks));
Thank you for helping make this Sankey engine production-grade!
```
---

### ✅ Final Advice

- ✅ You now have bulletproof, non-brittle tests
- ✅ You’re compatible with `d3-sankey`
- ✅ You're set up for open source collaboration and trust

Ready to submit this to pub.dev or GitHub? I can help you generate your `CHANGELOG.md`, `LICENSE`, and pubspec polish if you want.