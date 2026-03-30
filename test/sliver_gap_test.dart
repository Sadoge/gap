import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  testWidgets('SliverGap constructors', (WidgetTester tester) async {
    const SliverGap a = SliverGap(0);
    expect(a.mainAxisExtent, 0);
    expect(a.color, null);

    const SliverGap b = SliverGap(10, color: Colors.red);
    expect(b.mainAxisExtent, 10);
    expect(b.color, Colors.red);
  });

  testWidgets('Horizontal SliverGap layoutExtent', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: <Widget>[
            SliverGap(100),
          ],
        ),
      ),
    );

    final RenderSliver sliver = tester.renderObject(find.byType(SliverGap));
    expect(sliver.geometry!.layoutExtent, 100);
    expect(sliver.geometry!.paintExtent, 100);
  });

  testWidgets('Vertical SliverGap layoutExtent', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGap(100),
          ],
        ),
      ),
    );

    final RenderSliver sliver = tester.renderObject(find.byType(SliverGap));
    expect(sliver.geometry!.layoutExtent, 100);
    expect(sliver.geometry!.paintExtent, 100);
  });

  testWidgets('SliverGap paints its color', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGap(40, color: Colors.red),
          ],
        ),
      ),
    );

    expect(find.byType(SliverGap), paints..rect(color: Colors.red));
  });

  testWidgets('SliverGap paintExtent shrinks with scroll offset',
      (WidgetTester tester) async {
    final ScrollController controller =
        ScrollController(initialScrollOffset: 75);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          controller: controller,
          slivers: const <Widget>[
            SliverGap(100, color: Colors.red),
          ],
        ),
      ),
    );

    final RenderSliver sliver = tester.renderObject(find.byType(SliverGap));
    expect(sliver.geometry!.scrollExtent, 100);
    expect(sliver.geometry!.paintExtent, 25);
  });
}
