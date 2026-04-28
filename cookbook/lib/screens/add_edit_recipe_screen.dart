
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/constants.dart';

class AddEditRecipeScreen extends StatefulWidget {
  final Recipe? recipe; // null = add mode, not null = edit mode

  const AddEditRecipeScreen({super.key, this.recipe});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _imageController;
  late TextEditingController _cookTimeController;
  String _category = 'Breakfast';
  String _difficulty = 'Easy';
  double _rating = 3.0;
  bool _isFormInvalid = false;

  List<Map<String, TextEditingController>> _ingredients = [];
  List<TextEditingController> _steps = [];

  @override
  void initState() {
    super.initState();
    final r = widget.recipe;
    _titleController = TextEditingController(text: r?.title ?? '');
    _imageController = TextEditingController(text: r?.imageUrl ?? '');
    _cookTimeController =
        TextEditingController(text: r?.cookTime.toString() ?? '30');
    _category = r?.category ?? 'Breakfast';
    _difficulty = r?.difficulty ?? 'Easy';
    _rating = r?.rating ?? 3.0;

    if (r != null) {
      _ingredients = r.ingredients
          .map((i) => {
                'name': TextEditingController(text: i.name),
                'qty': TextEditingController(text: i.quantity),
              })
          .toList();
      _steps =
          r.steps.map((s) => TextEditingController(text: s)).toList();
    } else {
      _addIngredient();
      _addStep();
    }
  }

  void _addIngredient() {
    setState(() => _ingredients.add({
          'name': TextEditingController(),
          'qty': TextEditingController(),
        }));
  }

  void _addStep() {
    setState(() => _steps.add(TextEditingController()));
  }

  void _removeIngredient(int index) {
    setState(() => _ingredients.removeAt(index));
  }

  void _removeStep(int index) {
    setState(() => _steps.removeAt(index));
  }

  void _onSave() {
    if (!_formKey.currentState!.validate() ||
        _ingredients.isEmpty ||
        _steps.isEmpty) {
      setState(() => _isFormInvalid = true);
      return;
    }
    setState(() => _isFormInvalid = false);
    Navigator.pop(context);
  }

  Widget _inputField(TextEditingController ctrl, String hint,
      {TextInputType? keyboard, String? Function(String?)? validator}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      validator: validator,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: kCardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child:
              const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        leadingWidth: 70,
        title: Text(
          widget.recipe == null ? 'Add Recipe' : 'Edit Recipe',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: const Text('Save',
                style: TextStyle(color: kPrimaryColor)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error Banner
              if (_isFormInvalid)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Form is invalid',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

              // Title
              const Text('Recipe Title *',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _inputField(
                _titleController,
                'Enter recipe title',
                validator: (v) =>
                    v == null || v.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),

              // Category
              const Text('Category',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: kCardDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: kCardDark,
                  items: kCategories
                      .where((c) => c != 'All')
                      .map((c) =>
                          DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v!),
                ),
              ),
              const SizedBox(height: 16),

              // Cook Time
              const Text('Cook Time (minutes) *',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _inputField(
                _cookTimeController,
                '30',
                keyboard: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Cook time required' : null,
              ),
              const SizedBox(height: 16),

              // Difficulty
              const Text('Difficulty',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Row(
                children: ['Easy', 'Medium', 'Hard'].map((d) {
                  final selected = _difficulty == d;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => setState(() => _difficulty = d),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                selected ? kPrimaryColor : kCardDark,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              d,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: selected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Image URL
              const Text('Image URL (optional)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _inputField(
                  _imageController, 'https://example.com/image.jpg'),
              const SizedBox(height: 16),

              // Rating Slider
              Text('Rating: ${_rating.toStringAsFixed(1)}',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Slider(
                value: _rating,
                min: 1,
                max: 5,
                divisions: 8,
                activeColor: kPrimaryColor,
                onChanged: (v) => setState(() => _rating = v),
              ),
              const SizedBox(height: 16),

              // Ingredients
              const Text('Ingredients *',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ..._ingredients.asMap().entries.map((entry) {
                final i = entry.key;
                final ctrl = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: ctrl['name'],
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Ingredient name',
                            hintStyle:
                                TextStyle(color: Colors.grey.shade600),
                            filled: true,
                            fillColor: kCardDark,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: ctrl['qty'],
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Qty',
                            hintStyle:
                                TextStyle(color: Colors.grey.shade600),
                            filled: true,
                            fillColor: kCardDark,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red),
                        onPressed: () => _removeIngredient(i),
                      ),
                    ],
                  ),
                );
              }),
              OutlinedButton.icon(
                onPressed: _addIngredient,
                icon: const Icon(Icons.add, color: kPrimaryColor),
                label: const Text('Add Ingredient',
                    style: TextStyle(color: kPrimaryColor)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: kPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Steps
              const Text('Cooking Steps *',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ..._steps.asMap().entries.map((entry) {
                final i = entry.key;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(top: 10, right: 8),
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: entry.value,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Describe this step...',
                            hintStyle:
                                TextStyle(color: Colors.grey.shade600),
                            filled: true,
                            fillColor: kCardDark,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red),
                        onPressed: () => _removeStep(i),
                      ),
                    ],
                  ),
                );
              }),
              OutlinedButton.icon(
                onPressed: _addStep,
                icon: const Icon(Icons.add, color: kPrimaryColor),
                label: const Text('Add Step',
                    style: TextStyle(color: kPrimaryColor)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: kPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}