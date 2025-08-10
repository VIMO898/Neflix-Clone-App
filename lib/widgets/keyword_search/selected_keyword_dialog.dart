import 'package:app/widgets/general/centered_message.dart';
import 'package:flutter/material.dart';

import '../../models/general/keyword_model.dart';
import '../settings/dialogs/setting_dialog.dart';
import '../settings/setting_tile.dart';

class SelectedKeywordDialog extends StatefulWidget {
  final List<KeywordModel> selectedKeywords;
  final void Function(KeywordModel keyword) onRemoveSelectedKeyword;
  const SelectedKeywordDialog({
    super.key,
    required this.selectedKeywords,
    required this.onRemoveSelectedKeyword,
  });

  @override
  State<SelectedKeywordDialog> createState() => _SelectedKeywordDialogState();
}

class _SelectedKeywordDialogState extends State<SelectedKeywordDialog> {
  List<KeywordModel> _keywords = [];
  @override
  void initState() {
    super.initState();
    _keywords = widget.selectedKeywords;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRemoveSelectedKeyword(KeywordModel selectedKeyword) {
    _keywords = _keywords.where((k) => k.id != selectedKeyword.id).toList();
    widget.onRemoveSelectedKeyword(selectedKeyword);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SettingDialog(
      title: 'Selected Keywords',
      centeredTitle: true,
      height: 450,
      child: _keywords.isEmpty
          ? CenteredMessage(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 32),
              icon: Icons.filter_list_outlined,
              title: 'Empty List',
              subtitle: 'Search & select keywords to see them here.',
            )
          : ListView.builder(
              itemCount: widget.selectedKeywords.length,
              itemBuilder: (context, index) {
                final keyword = widget.selectedKeywords[index];
                return SettingTile(
                  title: keyword.name,

                  addBottomDivider: false,
                  trailingWidget: IconButton(
                    onPressed: () => _handleRemoveSelectedKeyword(keyword),
                    icon: Icon(Icons.close_rounded, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
