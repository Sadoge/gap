import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

void main() {
  testWidgets('Gap constructors', (WidgetTester tester) async {
    const Gap a = Gap(0);
    expect(a.mainAxisExtent, 0);
    expect(a.crossAxisExtent, null);
    expect(a.color, null);

    const Gap b = Gap(10, crossAxisExtent: 20, color: Colors.red);
    expect(b.mainAxisExtent, 10);
    expect(b.crossAxisExtent, 20);
    expect(b.color, Colors.red);

    const MaxGap c = MaxGap(0);
    expect(c.mainAxisExtent, 0);
    expect(c.crossAxisExtent, null);
    expect(c.color, null);
    expect(c.fit, FlexFit.loose);

    const MaxGap d = MaxGap(
      10,
      crossAxisExtent: 20,
      color: Colors.red,
      fit: FlexFit.tight,
    );
    expect(d.mainAxisExtent, 10);
    expect(d.crossAxisExtent, 20);
    expect(d.color, Colors.red);
    expect(d.fit, FlexFit.tight);

    const Gap e = Gap.expand(10, color: Colors.red);
    expect(e.mainAxisExtent, 10);
    expect(e.crossAxisExtent, double.infinity);
    expect(e.color, Colors.red);

    const MaxGap f = MaxGap.expand(
      10,
      color: Colors.red,
      fit: FlexFit.tight,
    );
    expect(f.mainAxisExtent, 10);
    expect(f.crossAxisExtent, double.infinity);
    expect(f.color, Colors.red);
    expect(f.fit, FlexFit.tight);
  });

  testWidgets('Gap size in a Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Gap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 100);
    expect(box.size.height, 20);
  });

  testWidgets('Gap size in a Column', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Column(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Gap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.height, 100);
    expect(box.size.width, 20);
  });

  testWidgets('Gap.expand size in a Column', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          width: 200,
          child: Column(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Gap.expand(100),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.height, 100);
    expect(box.size.width, 200);
  });

  testWidgets('Gap defaults to zero cross-axis extent in a Row',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Gap(100),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.size.width, 100);
    expect(box.size.height, 0);
  });

  testWidgets('Gap paints its color', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Gap(40, crossAxisExtent: 20, color: Colors.red),
        ],
      ),
    );

    expect(find.byType(Gap), paints..rect(color: Colors.red));
  });

  testWidgets('Gap intrinsic sizes use zero cross-axis extent by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Column(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Gap(40),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(Gap));
    expect(box.getMinIntrinsicWidth(double.infinity), 0);
    expect(box.getMaxIntrinsicWidth(double.infinity), 0);
    expect(box.getMinIntrinsicHeight(double.infinity), 40);
    expect(box.getMaxIntrinsicHeight(double.infinity), 40);
  });

  testWidgets('MaxGap size in a Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Row(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          MaxGap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.width, 100);
    expect(box.size.height, 20);
  });

  testWidgets('MaxGap size in a constrained Row', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          width: 50,
          child: Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              MaxGap(100, crossAxisExtent: 20),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.width, 50);
    expect(box.size.height, 20);
  });

  testWidgets('MaxGap size in a Column', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Column(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          MaxGap(100, crossAxisExtent: 20),
        ],
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.height, 100);
    expect(box.size.width, 20);
  });

  testWidgets('MaxGap size in a constrained Column',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          height: 50,
          child: Column(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              MaxGap(100, crossAxisExtent: 20),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.height, 50);
    expect(box.size.width, 20);
  });

  testWidgets('MaxGap fit can be made tight', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Center(
        child: SizedBox(
          width: 200,
          child: Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              MaxGap(100, crossAxisExtent: 20, fit: FlexFit.tight),
            ],
          ),
        ),
      ),
    );

    final RenderBox box = tester.renderObject(find.byType(MaxGap));
    expect(box.size.width, 200);
    expect(box.size.height, 20);
  });

  testWidgets(
      'Throws FlutterError with correct message when Gap is not inside a Flex',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Gap(0),
    );

    await tester.pump();

    final dynamic error = tester.takeException();
    expect(error, isFlutterError);
    expect(
      error.toStringDeep(),
      equalsIgnoringHashCodes(
        'FlutterError\n'
        '   A Gap widget must be placed directly inside a Flex widget or its\n'
        '   fallbackDirection must not be null\n',
      ),
    );
  });
}
