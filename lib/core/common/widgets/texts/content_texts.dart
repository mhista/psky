import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:flutter/material.dart';

// Model for notification content sections
class NotificationSection {
  final String text;
  final NotificationTextStyle style;

  const NotificationSection({
    required this.text,
    required this.style,
  });
}

// Enum for text styles
enum NotificationTextStyle {
  title,
  subtitle,
  body,
  caption,
}

// Configuration for notification styling
class NotificationStyleConfig {
  final double titleSize;
  final double subtitleSize;
  final double bodySize;
  final double captionSize;
  final FontWeight titleWeight;
  final FontWeight subtitleWeight;
  final FontWeight bodyWeight;
  final FontWeight captionWeight;
  final double titleSpacing;
  final double subtitleSpacing;
  final double bodySpacing;
  final double titleHeight;
  final double subtitleHeight;
  final double bodyHeight;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? bodyColor;
  final Color? captionColor;

  const NotificationStyleConfig({
    this.titleSize = 28,
    this.subtitleSize = 13,
    this.bodySize = 15,
    this.captionSize = 12,
    this.titleWeight = FontWeight.bold,
    this.subtitleWeight = FontWeight.w400,
    this.bodyWeight = FontWeight.w400,
    this.captionWeight = FontWeight.w300,
    this.titleSpacing = 8,
    this.subtitleSpacing = 16,
    this.bodySpacing = 12,
    this.titleHeight = 1.3,
    this.subtitleHeight = 1.4,
    this.bodyHeight = 1.6,
    this.titleColor,
    this.subtitleColor,
    this.bodyColor,
    this.captionColor,
  });

  NotificationStyleConfig copyWith({
    double? titleSize,
    double? subtitleSize,
    double? bodySize,
    double? captionSize,
    FontWeight? titleWeight,
    FontWeight? subtitleWeight,
    FontWeight? bodyWeight,
    FontWeight? captionWeight,
    double? titleSpacing,
    double? subtitleSpacing,
    double? bodySpacing,
    double? titleHeight,
    double? subtitleHeight,
    double? bodyHeight,
    Color? titleColor,
    Color? subtitleColor,
    Color? bodyColor,
    Color? captionColor,
  }) {
    return NotificationStyleConfig(
      titleSize: titleSize ?? this.titleSize,
      subtitleSize: subtitleSize ?? this.subtitleSize,
      bodySize: bodySize ?? this.bodySize,
      captionSize: captionSize ?? this.captionSize,
      titleWeight: titleWeight ?? this.titleWeight,
      subtitleWeight: subtitleWeight ?? this.subtitleWeight,
      bodyWeight: bodyWeight ?? this.bodyWeight,
      captionWeight: captionWeight ?? this.captionWeight,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      subtitleSpacing: subtitleSpacing ?? this.subtitleSpacing,
      bodySpacing: bodySpacing ?? this.bodySpacing,
      titleHeight: titleHeight ?? this.titleHeight,
      subtitleHeight: subtitleHeight ?? this.subtitleHeight,
      bodyHeight: bodyHeight ?? this.bodyHeight,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      bodyColor: bodyColor ?? this.bodyColor,
      captionColor: captionColor ?? this.captionColor,
    );
  }
}

// Main notification content widget
class NotificationContent extends StatelessWidget {
  final List<NotificationSection> sections;
  final NotificationStyleConfig? styleConfig;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment alignment;
  final double? maxWidth;

  const NotificationContent({
    super.key,
    required this.sections,
    this.styleConfig,
    this.padding,
    this.alignment = CrossAxisAlignment.start,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final config = styleConfig ?? const NotificationStyleConfig();
    final effectivePadding = padding ?? const EdgeInsets.all(16);

    Widget content = Column(
      crossAxisAlignment: alignment,
      children: _buildSections(config),
    );

    if (maxWidth != null) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: content,
        ),
      );
    }

    return SingleChildScrollView(
      padding: effectivePadding,
      child: content,
    );
  }

  List<Widget> _buildSections(NotificationStyleConfig config) {
    final List<Widget> widgets = [];

    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final isLast = i == sections.length - 1;

      widgets.add(_NotificationText(
        text: section.text,
        style: section.style,
        config: config,
      ));

      if (!isLast) {
        widgets.add(SizedBox(height: _getSpacing(section.style, config)));
      }
    }

    return widgets;
  }

  double _getSpacing(NotificationTextStyle style, NotificationStyleConfig config) {
    switch (style) {
      case NotificationTextStyle.title:
        return config.titleSpacing;
      case NotificationTextStyle.subtitle:
        return config.subtitleSpacing;
      case NotificationTextStyle.body:
      case NotificationTextStyle.caption:
        return config.bodySpacing;
    }
  }
}

// Individual text widget using ResponsiveText
class _NotificationText extends StatelessWidget {
  final String text;
  final NotificationTextStyle style;
  final NotificationStyleConfig config;

  const _NotificationText({
    required this.text,
    required this.style,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = _getFontSize();
    final fontWeight = _getFontWeight();
    final color = _getColor();
    final height = _getHeight();

    return ResponsiveText(text)
        .withSize(fontSize)
        .withWeight(fontWeight)
        .withHeight(height)
        .copyWith(color: color);
  }

  double _getFontSize() {
    switch (style) {
      case NotificationTextStyle.title:
        return config.titleSize;
      case NotificationTextStyle.subtitle:
        return config.subtitleSize;
      case NotificationTextStyle.body:
        return config.bodySize;
      case NotificationTextStyle.caption:
        return config.captionSize;
    }
  }

  FontWeight _getFontWeight() {
    switch (style) {
      case NotificationTextStyle.title:
        return config.titleWeight;
      case NotificationTextStyle.subtitle:
        return config.subtitleWeight;
      case NotificationTextStyle.body:
        return config.bodyWeight;
      case NotificationTextStyle.caption:
        return config.captionWeight;
    }
  }

  Color? _getColor() {
    switch (style) {
      case NotificationTextStyle.title:
        return config.titleColor;
      case NotificationTextStyle.subtitle:
        return config.subtitleColor;
      case NotificationTextStyle.body:
        return config.bodyColor;
      case NotificationTextStyle.caption:
        return config.captionColor;
    }
  }

  double _getHeight() {
    switch (style) {
      case NotificationTextStyle.title:
        return config.titleHeight;
      case NotificationTextStyle.subtitle:
        return config.subtitleHeight;
      case NotificationTextStyle.body:
      case NotificationTextStyle.caption:
        return config.bodyHeight;
    }
  }
}

// Builder pattern for easy construction
class NotificationContentBuilder {
  final List<NotificationSection> _sections = [];
  NotificationStyleConfig? _styleConfig;
  EdgeInsetsGeometry? _padding;
  CrossAxisAlignment _alignment = CrossAxisAlignment.start;
  double? _maxWidth;

  NotificationContentBuilder addTitle(String text) {
    _sections.add(NotificationSection(
      text: text,
      style: NotificationTextStyle.title,
    ));
    return this;
  }

  NotificationContentBuilder addSubtitle(String text) {
    _sections.add(NotificationSection(
      text: text,
      style: NotificationTextStyle.subtitle,
    ));
    return this;
  }

  NotificationContentBuilder addBody(String text) {
    _sections.add(NotificationSection(
      text: text,
      style: NotificationTextStyle.body,
    ));
    return this;
  }

  NotificationContentBuilder addCaption(String text) {
    _sections.add(NotificationSection(
      text: text,
      style: NotificationTextStyle.caption,
    ));
    return this;
  }

  NotificationContentBuilder addSection(NotificationSection section) {
    _sections.add(section);
    return this;
  }

  NotificationContentBuilder addParagraph(String text) {
    return addBody(text);
  }

  NotificationContentBuilder addMultipleParagraphs(List<String> paragraphs) {
    for (final paragraph in paragraphs) {
      addBody(paragraph);
    }
    return this;
  }

  // Automatically split text into paragraphs by newlines
  NotificationContentBuilder addBodyWithAutoParagraphs(String text) {
    final paragraphs = text
        .split('\n')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
    
    for (final paragraph in paragraphs) {
      addBody(paragraph);
    }
    return this;
  }

  // Split by custom delimiter
  NotificationContentBuilder addBodyWithDelimiter(String text, String delimiter) {
    final paragraphs = text
        .split(delimiter)
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
    
    for (final paragraph in paragraphs) {
      addBody(paragraph);
    }
    return this;
  }

  NotificationContentBuilder withStyleConfig(NotificationStyleConfig config) {
    _styleConfig = config;
    return this;
  }

  NotificationContentBuilder withPadding(EdgeInsetsGeometry padding) {
    _padding = padding;
    return this;
  }

  NotificationContentBuilder withAlignment(CrossAxisAlignment alignment) {
    _alignment = alignment;
    return this;
  }

  NotificationContentBuilder withMaxWidth(double width) {
    _maxWidth = width;
    return this;
  }

  Widget build() {
    return NotificationContent(
      sections: _sections,
      styleConfig: _styleConfig,
      padding: _padding,
      alignment: _alignment,
      maxWidth: _maxWidth,
    );
  }
}

// Preset configurations for common use cases
class NotificationStylePresets {
  static const standard = NotificationStyleConfig();
  
  static const compact = NotificationStyleConfig(
    titleSize: 24,
    subtitleSize: 11,
    bodySize: 13,
    titleSpacing: 6,
    subtitleSpacing: 12,
    bodySpacing: 8,
  );
  
  static const spacious = NotificationStyleConfig(
    titleSize: 32,
    subtitleSize: 15,
    bodySize: 17,
    titleSpacing: 12,
    subtitleSpacing: 20,
    bodySpacing: 16,
  );
  
  static const dark = NotificationStyleConfig(
    titleColor: Color(0xFFFFFFFF),
    subtitleColor: Color(0xFFB0B0B0),
    bodyColor: Color(0xFFE0E0E0),
  );
  
  static const light = NotificationStyleConfig(
    titleColor: Color(0xFF1F1F1F),
    subtitleColor: Color(0xFF666666),
    bodyColor: Color(0xFF333333),
  );
}

// Example usage with your ResponsiveText
class NotificationDetailsExample extends StatelessWidget {
  const NotificationDetailsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notification Details'),
        backgroundColor: const Color(0xFF6B5FCD),
        foregroundColor: Colors.white,
      ),
      body: _buildNotificationContent(),
    );
  }

  Widget _buildNotificationContent() {
    return NotificationContentBuilder()
      .addTitle('Your test results are ready!')
      .addSubtitle('Oct. 10 2025, 1:49PM (4 days ago)')
      .addBody(
        'In this examination, you will be tested on the following subjects: [Insert Subjects e.g., Mathematics, English Language, Biology].',
      )
      .addBody(
        'You will be given a total of [X questions], carefully selected from past and model questions in the chosen subjects. These questions are designed to simulate the real WAEC experience and help you practice effectively.',
      )
      .addBody(
        'You are expected to read each question carefully before selecting or providing an answer. Use the Next button to move forward, and the Previous button if you wish to return to an earlier question. You may also mark any question for review by selecting the "Review Later" option, which allows you to revisit flagged questions before submission.',
      )
      .withStyleConfig(NotificationStylePresets.light)
      .withPadding(const EdgeInsets.all(24))
      .build();
  }
}


