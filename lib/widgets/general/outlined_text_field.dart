// import 'package:flutter/material.dart';

// class OutlinedTextField extends StatelessWidget {
//   final String hintText;
//   final TextInputType? keyboardType;
//   final int maxLength;
//   final int maxLines;
//   const OutlinedTextField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//     final colorScheme = theme.colorScheme;
//     final defaultBorderSide = BorderSide(
//         color: colorScheme.secondary.withValues(alpha: 0.45), width: 1.5);
//     final defaultOutlinedInputBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: defaultBorderSide,
//     );
//     final defaultFocusedOutlinedBorder = defaultOutlinedInputBorder.copyWith(
//         borderSide: defaultBorderSide.copyWith(width: 2.0));
//     final errorOutlinedBorder = defaultOutlinedInputBorder.copyWith(
//         borderSide: defaultBorderSide.copyWith(color: Colors.red.shade600));
//     final errorFocusedOutlinedBorder = errorOutlinedBorder.copyWith(
//         borderSide: defaultBorderSide.copyWith(width: 2.0));
//     final defaultInputContentPadding =
//         const EdgeInsets.symmetric(horizontal: 14, vertical: 16);

//     return Padding(
//         padding: const EdgeInsets.only(bottom: 22),
//         child: FormField(

//           keyboardType: ,
//           maxLines: ,
//           maxLength: ,
//           autocorrect: false,
//           onChanged: ,
//           validat
//           style: textTheme.titleLarge,

//             decoration: InputDecoration(
//           border: defaultOutlinedInputBorder,
//           enabledBorder: defaultOutlinedInputBorder,
//           errorBorder: errorOutlinedBorder,
//           focusedBorder: defaultFocusedOutlinedBorder,
//           focusedErrorBorder: errorFocusedOutlinedBorder,
//           contentPadding: defaultInputContentPadding,
//           hintText: '',
//           hintStyle: textTheme.titleLarge?.copyWith(color: colorScheme.secondary),

//         // )
//         )
//         );
//   }
// }
