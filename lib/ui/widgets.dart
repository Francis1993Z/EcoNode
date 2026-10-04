// Petits composants réutilisés dans les panneaux.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'format.dart';
import 'palette.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const Section(this.title, this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: pal.sheet,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pal.rule2),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.toUpperCase(),
            style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
        const SizedBox(height: 8),
        ...children,
      ]),
    );
  }
}

class KV extends StatelessWidget {
  final String k;
  final String v;
  final Color? color;
  const KV(this.k, this.v, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Text(k, style: TextStyle(color: pal.ink2, fontSize: 12.5))),
        const SizedBox(width: 8),
        Text(v, style: mono(color ?? pal.ink, 12.5, weight: FontWeight.w600)),
      ]),
    );
  }
}

/// Champ numérique. Si [value] change pendant que l'on n'écrit pas, le texte suit la simulation.
class NumField extends StatefulWidget {
  final String label;
  final double? value;
  final String suffix;
  final int decimals;
  final void Function(double v) onSubmit;
  const NumField({
    super.key,
    required this.label,
    required this.value,
    required this.onSubmit,
    this.suffix = '',
    this.decimals = 2,
  });

  @override
  State<NumField> createState() => _NumFieldState();
}

class _NumFieldState extends State<NumField> {
  late final TextEditingController _c;
  final FocusNode _f = FocusNode();

  String _fmt(double? v) {
    if (v == null) return '';
    var s = v.toStringAsFixed(widget.decimals);
    if (s.contains('.')) {
      s = s.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
    }
    return s.replaceAll('.', ',');
  }

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: _fmt(widget.value));
    _f.addListener(() {
      if (!_f.hasFocus) _commit();
    });
  }

  @override
  void didUpdateWidget(covariant NumField old) {
    super.didUpdateWidget(old);
    if (!_f.hasFocus && _c.text != _fmt(widget.value)) _c.text = _fmt(widget.value);
  }

  void _commit() {
    final v = parseNum(_c.text);
    if (v != null && v.isFinite && (widget.value == null || (v - widget.value!).abs() > 1e-9)) {
      widget.onSubmit(v);
    } else {
      _c.text = _fmt(widget.value);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    _f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return TextField(
      controller: _c,
      focusNode: _f,
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.\- ]'))],
      style: mono(pal.ink, 13),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _commit(),
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        suffixText: widget.suffix.isEmpty ? null : widget.suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class Btn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool primary;
  final bool danger;
  final IconData? icon;
  const Btn(this.label, this.onTap, {super.key, this.primary = false, this.danger = false, this.icon});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final c = danger ? pal.bad : (primary ? pal.accent : pal.ink);
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
      style: OutlinedButton.styleFrom(
        foregroundColor: c,
        backgroundColor: primary ? pal.accentSoft : null,
        side: BorderSide(color: primary || danger ? c : pal.rule),
        padding: EdgeInsets.symmetric(horizontal: icon == null ? 12 : 10, vertical: 10),
        minimumSize: const Size(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class ParamSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final String Function(double) format;
  final void Function(double) onChanged;
  final String? hint;
  const ParamSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.format,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(label, style: TextStyle(color: pal.ink, fontSize: 12.5))),
        Text(format(value), style: mono(pal.accent, 12.5, weight: FontWeight.w700)),
      ]),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(trackHeight: 3, overlayShape: SliderComponentShape.noOverlay),
        child: Slider(value: value.clamp(min, max).toDouble(), min: min, max: max, onChanged: onChanged),
      ),
      if (hint != null) Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(hint!, style: TextStyle(color: pal.ink3, fontSize: 11))),
    ]);
  }
}

class Pill extends StatelessWidget {
  final String text;
  final Color color;
  const Pill(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
        child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
      );
}
