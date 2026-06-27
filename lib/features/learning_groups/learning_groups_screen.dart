import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/features/learning_groups/learning_group_models.dart';
import 'package:mobile_flutter/features/learning_groups/learning_group_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningGroupsScreen extends StatefulWidget {
  const LearningGroupsScreen({super.key});

  @override
  State<LearningGroupsScreen> createState() => _LearningGroupsScreenState();
}

class _LearningGroupsScreenState extends State<LearningGroupsScreen> {
  final LearningGroupService _service = LearningGroupService();
  final TextEditingController _joinController = TextEditingController();

  List<LearningGroupSummary> _groups = const [];
  List<LearningGroupPost> _posts = const [];
  LearningGroupDetails? _details;
  LearningGroupSummary? _selectedGroup;
  String _filter = 'ALL';
  bool _loading = true;
  bool _postsLoading = false;
  bool _syncing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  @override
  void dispose() {
    _joinController.dispose();
    super.dispose();
  }

  Future<void> _loadGroups() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final groups = await _service.getMyGroups();
      if (!mounted) return;
      setState(() {
        _groups = groups;
        _selectedGroup = groups.isEmpty
            ? null
            : groups.firstWhere(
                (group) => group.groupId == _selectedGroup?.groupId,
                orElse: () => groups.first,
              );
        _loading = false;
      });
      if (_selectedGroup != null) {
        await _loadSelectedGroup();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = AppHelpers.userErrorMessage(e);
        _loading = false;
      });
    }
  }

  Future<void> _loadSelectedGroup() async {
    final group = _selectedGroup;
    if (group == null) return;

    setState(() {
      _postsLoading = true;
      _error = null;
    });

    try {
      final results = await Future.wait<dynamic>([
        _service.getDetails(group.groupId),
        _service.getPosts(
          group.groupId,
          postType: _filter == 'ALL' ? null : _filter,
        ),
      ]);
      if (!mounted) return;
      setState(() {
        _details = results[0] as LearningGroupDetails;
        _posts = results[1] as List<LearningGroupPost>;
        _postsLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = AppHelpers.userErrorMessage(e);
        _postsLoading = false;
      });
    }
  }

  Future<void> _joinGroup() async {
    final code = _joinController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    try {
      final joined = await _service.join(code);
      if (!mounted) return;
      _joinController.clear();
      AppHelpers.showSuccess(context, 'Joined ${joined.groupName}');
      await _loadGroups();
    } catch (e) {
      if (!mounted) return;
      AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
    }
  }

  Future<void> _syncMaterials() async {
    final group = _selectedGroup;
    if (group == null || _syncing) return;

    setState(() => _syncing = true);
    try {
      final result = await _service.syncMaterials(group.groupId);
      if (!mounted) return;
      AppHelpers.showSuccess(
        context,
        'AI sync complete: ${result['indexed'] ?? 0} indexed',
      );
    } catch (e) {
      if (!mounted) return;
      AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _openComposer() async {
    final group = _selectedGroup;
    if (group == null) return;

    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _PostComposer(group: group, service: _service),
    );

    if (created == true) {
      await _loadSelectedGroup();
    }
  }

  Future<void> _openComments(LearningGroupPost post) async {
    final group = _selectedGroup;
    if (group == null) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _CommentsSheet(
        groupId: group.groupId,
        post: post,
        service: _service,
        onCommentAdded: _loadSelectedGroup,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null && _groups.isEmpty) {
      return _ErrorState(message: _error!, onRetry: _loadGroups);
    }

    final group = _selectedGroup;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: group?.canPost == true
          ? FloatingActionButton.extended(
              onPressed: _openComposer,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Post'),
            )
          : null,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _loadGroups,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderCard(
                      details: _details,
                      group: group,
                      syncing: _syncing,
                      onSync: _syncMaterials,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _JoinRow(
                      controller: _joinController,
                      onJoin: _joinGroup,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _GroupSelector(
                      groups: _groups,
                      selected: group,
                      onSelected: (next) {
                        setState(() {
                          _selectedGroup = next;
                          _filter = 'ALL';
                        });
                        _loadSelectedGroup();
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _FilterChips(
                      value: _filter,
                      onChanged: (value) {
                        setState(() => _filter = value);
                        _loadSelectedGroup();
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (_postsLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_groups.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(
                  icon: Icons.groups_2_outlined,
                  title: 'No learning groups yet',
                  message: 'Join with an access code or wait for your enrolled course groups.',
                ),
              )
            else if (_posts.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(
                  icon: Icons.article_outlined,
                  title: 'No posts yet',
                  message: 'Materials, assignments, announcements, and comments will appear here.',
                ),
              )
            else
              SliverList.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      index == 0 ? 0 : AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: _PostCard(
                      post: post,
                      isOwner: group?.isOwner == true,
                      onComments: () => _openComments(post),
                      onTogglePin: () async {
                        await _service.togglePin(group!.groupId, post.postId);
                        await _loadSelectedGroup();
                      },
                      onDelete: () async {
                        await _service.deletePost(group!.groupId, post.postId);
                        await _loadSelectedGroup();
                      },
                    ),
                  );
                },
              ),
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom + 88),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.details,
    required this.group,
    required this.syncing,
    required this.onSync,
  });

  final LearningGroupDetails? details;
  final LearningGroupSummary? group;
  final bool syncing;
  final VoidCallback onSync;

  @override
  Widget build(BuildContext context) {
    final selected = group;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: const LinearGradient(
          colors: [Color(0xFF115E59), Color(0xFF0F766E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  selected == null ? 'Learning Groups' : selected.course.code,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton.filledTonal(
                tooltip: 'Sync AI materials',
                onPressed: selected == null || syncing ? null : onSync,
                icon: syncing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            selected?.course.name ?? 'Course spaces for posts, files, assignments, and discussion.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.86)),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _HeaderChip('${details?.memberCount ?? 0} members'),
              if (selected != null) _HeaderChip(selected.myRole),
              if (selected?.accessCode != null && selected!.isOwner)
                _HeaderChip('Code ${selected.accessCode}'),
              if (selected != null)
                _HeaderChip(selected.allowStudentPosts ? 'Open posting' : 'Staff posts'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _JoinRow extends StatelessWidget {
  const _JoinRow({required this.controller, required this.onJoin});

  final TextEditingController controller;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.vpn_key_rounded),
              hintText: 'Access code',
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        FilledButton(onPressed: onJoin, child: const Text('Join')),
      ],
    );
  }
}

class _GroupSelector extends StatelessWidget {
  const _GroupSelector({
    required this.groups,
    required this.selected,
    required this.onSelected,
  });

  final List<LearningGroupSummary> groups;
  final LearningGroupSummary? selected;
  final ValueChanged<LearningGroupSummary> onSelected;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 98,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: groups.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final group = groups[index];
          final isSelected = group.groupId == selected?.groupId;
          return InkWell(
            onTap: () => onSelected(group),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Container(
              width: 220,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primarySoft : AppColors.card,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.course.code,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    group.course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    const filters = {
      'ALL': 'All',
      'ANNOUNCEMENT': 'Announcements',
      'MATERIAL': 'Materials',
      'ASSIGNMENT': 'Assignments',
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.entries.map((entry) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: value == entry.key,
              onSelected: (_) => onChanged(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.isOwner,
    required this.onComments,
    required this.onTogglePin,
    required this.onDelete,
  });

  final LearningGroupPost post;
  final bool isOwner;
  final VoidCallback onComments;
  final VoidCallback onTogglePin;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    _PostTypeBadge(post.postType),
                    if (post.isPinned) const _TinyBadge('Pinned'),
                    if (post.dueDate != null)
                      _TinyBadge('Due ${DateFormat('MMM d, h:mm a').format(post.dueDate!)}'),
                  ],
                ),
              ),
              if (isOwner)
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'pin') onTogglePin();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'pin',
                      child: Text(post.isPinned ? 'Unpin post' : 'Pin post'),
                    ),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${post.authorName} • ${_formatDate(post.createdAt)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if ((post.content ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              post.content!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
          if (post.attachments.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            ...post.attachments.map((attachment) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _AttachmentTile(attachment: attachment),
                )),
          ],
          const Divider(height: AppSpacing.lg),
          TextButton.icon(
            onPressed: onComments,
            icon: const Icon(Icons.mode_comment_outlined),
            label: Text('${post.commentCount} comments'),
          ),
        ],
      ),
    );
  }
}

class _PostTypeBadge extends StatelessWidget {
  const _PostTypeBadge(this.type);

  final String type;

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      'ASSIGNMENT' => AppColors.warning,
      'ANNOUNCEMENT' => AppColors.success,
      _ => AppColors.primary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        type.toLowerCase(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _TinyBadge extends StatelessWidget {
  const _TinyBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({required this.attachment});

  final LearningGroupAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final uri = Uri.tryParse(attachment.url);
          if (uri != null) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } catch (e) {
          if (context.mounted) {
            AppHelpers.showError(context, 'Could not open attachment.');
          }
        }
      },
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            const Icon(Icons.attach_file_rounded, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attachment.fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    _formatFileSize(attachment.fileSize),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Icon(Icons.open_in_new_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}

class _PostComposer extends StatefulWidget {
  const _PostComposer({required this.group, required this.service});

  final LearningGroupSummary group;
  final LearningGroupService service;

  @override
  State<_PostComposer> createState() => _PostComposerState();
}

class _PostComposerState extends State<_PostComposer> {
  final TextEditingController _contentController = TextEditingController();
  final List<PickedLearningGroupFile> _files = [];
  String _postType = 'MATERIAL';
  DateTime? _dueDate;
  bool _submitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: false,
    );
    if (result == null) return;

    final nextFiles = result.files
        .where((file) => file.path != null)
        .map((file) => PickedLearningGroupFile(name: file.name, path: file.path!))
        .toList();

    setState(() {
      _files
        ..clear()
        ..addAll(nextFiles.take(5));
    });
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dueDate ?? now.add(const Duration(hours: 1))),
    );
    if (time == null) return;

    setState(() {
      _dueDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _submit() async {
    if (_submitting) return;
    if (_postType == 'ASSIGNMENT' && _dueDate == null) {
      AppHelpers.showError(context, 'Assignments need a due date.');
      return;
    }
    if (_contentController.text.trim().isEmpty && _files.isEmpty) {
      AppHelpers.showError(context, 'Add text or at least one attachment.');
      return;
    }

    setState(() => _submitting = true);
    try {
      await widget.service.createPost(
        groupId: widget.group.groupId,
        postType: _postType,
        content: _contentController.text,
        dueDate: _dueDate,
        files: _files,
      );
      if (!mounted) return;
      AppHelpers.showSuccess(context, 'Post published');
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create post', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'MATERIAL', label: Text('Material')),
                ButtonSegment(value: 'ANNOUNCEMENT', label: Text('News')),
                ButtonSegment(value: 'ASSIGNMENT', label: Text('Task')),
              ],
              selected: {_postType},
              onSelectionChanged: (values) {
                setState(() {
                  _postType = values.first;
                  if (_postType != 'ASSIGNMENT') _dueDate = null;
                });
              },
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _contentController,
              minLines: 4,
              maxLines: 7,
              decoration: const InputDecoration(
                hintText: 'Write instructions, notes, or an announcement...',
              ),
            ),
            if (_postType == 'ASSIGNMENT') ...[
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: _pickDueDate,
                icon: const Icon(Icons.event_rounded),
                label: Text(
                  _dueDate == null
                      ? 'Set due date'
                      : DateFormat('MMM d, yyyy h:mm a').format(_dueDate!),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: _pickFiles,
              icon: const Icon(Icons.attach_file_rounded),
              label: Text(_files.isEmpty ? 'Attach files' : '${_files.length} files attached'),
            ),
            if (_files.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              ..._files.map((file) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.insert_drive_file_outlined),
                    title: Text(file.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      tooltip: 'Remove',
                      onPressed: () => setState(() => _files.remove(file)),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  )),
            ],
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submitting ? null : _submit,
                icon: _submitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(_submitting ? 'Publishing...' : 'Publish'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentsSheet extends StatefulWidget {
  const _CommentsSheet({
    required this.groupId,
    required this.post,
    required this.service,
    required this.onCommentAdded,
  });

  final int groupId;
  final LearningGroupPost post;
  final LearningGroupService service;
  final VoidCallback onCommentAdded;

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final TextEditingController _controller = TextEditingController();
  List<LearningGroupComment> _comments = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    try {
      final comments = await widget.service.getComments(
        widget.groupId,
        widget.post.postId,
      );
      if (!mounted) return;
      setState(() {
        _comments = comments;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
    }
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    try {
      final comment = await widget.service.createComment(
        widget.groupId,
        widget.post.postId,
        text,
      );
      if (!mounted) return;
      setState(() {
        _comments = [..._comments, comment];
        _controller.clear();
      });
      widget.onCommentAdded();
    } catch (e) {
      if (!mounted) return;
      AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.72,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Comments', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _comments.isEmpty
                      ? const Center(child: Text('No comments yet.'))
                      : ListView.separated(
                          itemCount: _comments.length,
                          separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                          itemBuilder: (context, index) {
                            final comment = _comments[index];
                            return Container(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceAlt,
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.authorName,
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(comment.content),
                                ],
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Write a comment...'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  onPressed: _send,
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: AppColors.textMuted),
            const SizedBox(height: AppSpacing.sm),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 42, color: AppColors.error),
            const SizedBox(height: AppSpacing.sm),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime? value) {
  if (value == null) return '';
  return DateFormat('MMM d, h:mm a').format(value);
}

String _formatFileSize(int? size) {
  if (size == null || size <= 0) return 'Unknown size';
  if (size < 1024 * 1024) return '${(size / 1024).ceil()} KB';
  return '${(size / 1024 / 1024).toStringAsFixed(1)} MB';
}
