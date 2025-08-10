import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:app/constants/enums.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:app/models/general/selectable_model.dart';
import 'package:app/providers/general/available_regions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/controllers/app_setting_controller_provider.dart';
import '../providers/general/supported_languages_provider_sorted.dart';
import '../widgets/settings/dialogs/setting_dialog_tile.dart';

class SelectableListViewScreen extends ConsumerStatefulWidget {
  final SelectableListViewType type;
  const SelectableListViewScreen({super.key, required this.type});

  @override
  ConsumerState<SelectableListViewScreen> createState() =>
      _SelectPreferredLanguageScreenState();
}

class _SelectPreferredLanguageScreenState
    extends ConsumerState<SelectableListViewScreen> {
  bool _isSearching = false;
  late FocusNode _searchFocusNode;
  late List<SelectableModel> _allSelectables;
  late List<SelectableModel> _selectables;
  late SelectableModel _selectedSelectable;
  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    final appSettings = ref.read(appSettingControllerProvider);
    switch (widget.type) {
      case SelectableListViewType.region:
        final allRegions = ref.read(availableRegionsProvider);
        final transformedList = allRegions
            .map((lang) => lang.toSelectable())
            .toList();
        _allSelectables = transformedList;
        _selectables = transformedList;
        _selectedSelectable = appSettings.region.toSelectable();
      case SelectableListViewType.language:
        final allLanguages = ref.read(supportedLanguagesProvider);
        final transformedList = allLanguages
            .map((lang) => lang.toSelectable())
            .toList();
        _allSelectables = transformedList;
        _selectables = transformedList;
        _selectedSelectable = appSettings.preferredLanguage.toSelectable();
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearchStatusToggle() {
    _selectables = _allSelectables;
    _isSearching = !_isSearching;
    setState(() {});
    _isSearching ? _searchFocusNode.requestFocus() : _searchFocusNode.unfocus();
  }

  void _handleItemSelection(SelectableModel selectable) {
    final notifier = ref.read(appSettingControllerProvider.notifier);
    switch (widget.type) {
      case SelectableListViewType.region:
        notifier.updateRegion(selectable.toRegion());
      case SelectableListViewType.language:
        notifier.updatePreferredLanguage(selectable.toSpokenLanguage());
    }
    _selectedSelectable = selectable;
    setState(() {});
  }

  void _handleSearchChange(String query) {
    final filteredLanguages = _allSelectables
        .where(
          (lang) =>
              lang.englishName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    _selectables = filteredLanguages;
    setState(() {});
  }

  final AlphabetListViewOptions options = AlphabetListViewOptions(
    listOptions: ListOptions(
      listHeaderBuilder: (context, symbol) {
        final theme = Theme.of(context);
        final textTheme = theme.textTheme;
        return ListTile(title: Text(symbol, style: textTheme.bodyLarge));
      },
      stickySectionHeader: false,
    ),
    scrollbarOptions: ScrollbarOptions(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.only(right: 15),
      symbolBuilder: (context, symbol, state) {
        final theme = Theme.of(context);
        final textTheme = theme.textTheme;
        final colorSheme = theme.colorScheme;
        final isActive = state == AlphabetScrollbarItemState.active;
        return CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? theme.primaryColor : theme.cardColor,
          child: Text(
            symbol,
            style: textTheme.labelMedium?.copyWith(color: colorSheme.primary),
          ),
        );
      },
      width: 35,
    ),
    overlayOptions: const OverlayOptions(showOverlay: false),
  );

  List<AlphabetListViewItemGroup> generateAlphabetGroups() {
    // Step 1: Sort languages by name
    _selectables.sort(
      (a, b) =>
          a.englishName.toLowerCase().compareTo(b.englishName.toLowerCase()),
    );

    // Step 2: Group by first letter
    final Map<String, List<SelectableModel>> grouped = {};
    for (var item in _selectables) {
      final letter = item.englishName.isNotEmpty
          ? item.englishName[0].toUpperCase()
          : '#';
      grouped.putIfAbsent(letter, () => []).add(item);
    }

    // Step 3: Convert to AlphabetListViewItemGroup list
    final List<AlphabetListViewItemGroup> groups = grouped.entries
        .map(
          (entry) => AlphabetListViewItemGroup(
            tag: entry.key,
            children: entry.value.map((e) => _buildTile(e)).toList(),
          ),
        )
        .toList();

    // Step 4: Ensure A-Z order
    groups.sort((a, b) => a.tag.compareTo(b.tag));
    return groups;
  }

  SettingDialogTile _buildTile(SelectableModel currItem) {
    return SettingDialogTile(
      title: currItem.englishName.capitalizeFirstLetter(),
      subtitle: currItem.name.isEmpty ? currItem.iso : currItem.name,
      selected: currItem == _selectedSelectable,
      onTap: () => _handleItemSelection(currItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectablesType = widget.type.name.capitalizeFirstLetter();
    return PopScope(
      canPop: !_isSearching,
      onPopInvokedWithResult: (didPop, result) => _handleSearchStatusToggle(),
      child: Scaffold(
        appBar: AppBar(
          title: !_isSearching
              ? Text('Choose $selectablesType')
              : TextField(
                  focusNode: _searchFocusNode,
                  style: theme.appBarTheme.titleTextStyle,
                  onChanged: _handleSearchChange,
                  decoration: InputDecoration(
                    hintText: 'Search $selectablesType',
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                ),
          actions: [
            IconButton(
              onPressed: _handleSearchStatusToggle,
              icon: Icon(Icons.search),
            ),
          ],
        ),

        body: !_isSearching
            ? AlphabetListView(
                options: options,
                items: generateAlphabetGroups(),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 12),
                itemCount: _selectables.length,
                itemBuilder: (context, index) {
                  final currLanguage = _selectables[index];
                  return _buildTile(currLanguage);
                },
              ),
      ),
    );
  }
}
