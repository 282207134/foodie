import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  final List<Location> _locations = [
    Location(
      id: '1',
      name: 'Home',
      address: '123 Main St, Apt 4B, Downtown',
      latitude: 37.7749,
      longitude: -122.4194,
      isDefault: true,
    ),
    Location(
      id: '2',
      name: 'Work',
      address: '456 Business Ave, Suite 100, Financial District',
      latitude: 37.7849,
      longitude: -122.4094,
      isDefault: false,
    ),
    Location(
      id: '3',
      name: 'Gym',
      address: '789 Fitness Blvd, Sports Complex',
      latitude: 37.7649,
      longitude: -122.4294,
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
        ),
        title: Text('My Locations', style: AppTextStyles.headline3Bold),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddLocationDialog,
            icon: const Icon(Icons.add_rounded, size: 26),
          ),
        ],
      ),
      body: SafeArea(
        child: _locations.isEmpty ? _buildEmptyState() : _buildLocationList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.location_on_rounded, size: 50, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            Text('No saved locations', style: AppTextStyles.headline3Bold),
            const SizedBox(height: 8),
            Text(
              'Add your first delivery address',
              style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Add Location',
              onPressed: _showAddLocationDialog,
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _locations.length,
      itemBuilder: (context, index) {
        return _buildLocationCard(_locations[index]);
      },
    );
  }

  Widget _buildLocationCard(Location location) {
    final iconData = _getLocationIcon(location.name);
    final iconColor = _getLocationColor(location.name);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: location.isDefault ? AppColors.primary.withValues(alpha: 0.3) : AppColors.lightGrey60,
          width: location.isDefault ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black10,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: iconColor, size: 26),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(location.name, style: AppTextStyles.headline5Semibold),
                    if (location.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Default',
                          style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location.address,
                  style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.black60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) => _handleLocationAction(value, location),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'set_default',
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: 20, color: AppColors.primary),
                    const SizedBox(width: 8),
                    const Text('Set as default'),
                  ],
                ),
                enabled: !location.isDefault,
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 20, color: AppColors.black60),
                    const SizedBox(width: 8),
                    const Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                    const SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: AppColors.error)),
                  ],
                ),
                enabled: _locations.length > 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getLocationIcon(String name) {
    switch (name.toLowerCase()) {
      case 'home':
        return Icons.home_rounded;
      case 'work':
        return Icons.work_rounded;
      case 'gym':
        return Icons.fitness_center_rounded;
      default:
        return Icons.location_on_rounded;
    }
  }

  Color _getLocationColor(String name) {
    switch (name.toLowerCase()) {
      case 'home':
        return AppColors.primary;
      case 'work':
        return AppColors.blue;
      case 'gym':
        return AppColors.orange100;
      default:
        return AppColors.primary;
    }
  }

  void _handleLocationAction(String action, Location location) {
    switch (action) {
      case 'set_default':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${location.name} set as default'),
            backgroundColor: AppColors.success100,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        break;
      case 'edit':
        _showEditLocationDialog(location);
        break;
      case 'delete':
        _showDeleteConfirmation(location);
        break;
    }
  }

  void _showAddLocationDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LocationFormSheet(
        onSave: (name, address) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$name added successfully'),
              backgroundColor: AppColors.success100,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        },
      ),
    );
  }

  void _showEditLocationDialog(Location location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LocationFormSheet(
        initialName: location.name,
        initialAddress: location.address,
        onSave: (name, address) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$name updated successfully'),
              backgroundColor: AppColors.success100,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(Location location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Location', style: AppTextStyles.headline4Bold),
        content: Text('Are you sure you want to delete ${location.name}?', style: AppTextStyles.bodytext1Regular),
        actions: [
          TextButtonWidget(
            text: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
          PrimaryButton(
            text: 'Delete',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${location.name} deleted'),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            isFullWidth: false,
          ),
        ],
      ),
    );
  }
}

class _LocationFormSheet extends StatefulWidget {
  final String? initialName;
  final String? initialAddress;
  final Function(String name, String address) onSave;

  const _LocationFormSheet({
    this.initialName,
    this.initialAddress,
    required this.onSave,
  });

  @override
  State<_LocationFormSheet> createState() => _LocationFormSheetState();
}

class _LocationFormSheetState extends State<_LocationFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  String _selectedType = 'Home';

  final List<String> _types = ['Home', 'Work', 'Gym', 'Other'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _addressController = TextEditingController(text: widget.initialAddress);
    if (widget.initialName != null) {
      _selectedType = widget.initialName!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey60,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.initialName != null ? 'Edit Location' : 'Add Location',
              style: AppTextStyles.headline3Bold,
            ),
            const SizedBox(height: 24),
            // Location Type
            Text('Location Type', style: AppTextStyles.headline4Semibold),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _types.map((type) => FilterChip(
                label: Text(type),
                selected: _selectedType == type,
                onSelected: (selected) => setState(() => _selectedType = type),
                selectedColor: AppColors.primary.withValues(alpha: 0.2),
                checkmarkColor: AppColors.primary,
                labelStyle: AppTextStyles.headline5Medium,
                side: BorderSide(color: _selectedType == type ? AppColors.primary : AppColors.lightGrey60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              )).toList(),
            ),
            const SizedBox(height: 24),
            // Name
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Label (e.g., Home, Work)',
                hintText: 'Enter a label',
                prefixIcon: Icon(Icons.label_outline_rounded, size: 22),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a label';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Address
            TextFormField(
              controller: _addressController,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'Enter full address',
                prefixIcon: Icon(Icons.location_on_outlined, size: 22),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an address';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: widget.initialName != null ? 'Save Changes' : 'Add Location',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSave(_nameController.text, _addressController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}