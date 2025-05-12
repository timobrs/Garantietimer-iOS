import 'package:flutter/cupertino.dart';
import 'package:garantietimer_ios/backend/device_service.dart';
import 'package:garantietimer_ios/backend/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final _deviceService = DeviceService();
  final _userService = UserService();
  final _formKey = GlobalKey<FormState>();

  // Controller für die Textfelder
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _notesController = TextEditingController();

  // Variablen für die Auswahl von Datum und Dateien
  DateTime? _selectedPurchaseDate;
  DateTime? _selectedWarrantyEndDate;
  File? _selectedImage;
  File? _selectedInvoice;
  bool _isLoading = false;

  // ImagePicker für die Auswahl von Bildern
  final ImagePicker _picker = ImagePicker();
  final DateFormat _displayDateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _storageDateFormatter = DateFormat('yyyy-MM-dd');

  // Liste der Gerätekategorien
  final List<String> _categories = [
    'Elektronik',
    'Arbeitsplatz',
    'Smart Home',
    'Küchengerät',
    'Bad',
    'Werkzeug',
    'Sonstiges',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _serialNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  //Header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: CupertinoTheme.of(
          context,
        ).textTheme.navTitleTextStyle.copyWith(color: CupertinoColors.black),
      ),
    );
  }

  //Datei auswählen Button
  Widget _buildFilePickerButton(
    IconData icon,
    String label,
    File? selectedFile,
    Future<void> Function() pickFile,
  ) {
    return Expanded(
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
        onPressed: _isLoading ? null : pickFile,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  selectedFile != null
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.systemBlue,
              size: 30.0,
            ),
            const SizedBox(height: 4.0),
            Text(
              selectedFile != null ? 'Ausgewählt' : label,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 14,
                color:
                    _isLoading
                        ? CupertinoColors.inactiveGray
                        : (selectedFile != null
                            ? CupertinoColors.systemGreen
                            : Color(0xFF0A2463)),
              ),
            ),
            if (selectedFile != null)
              Text(
                selectedFile.path.split('/').last,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 10,
                  color:
                      _isLoading
                          ? CupertinoColors.inactiveGray
                          : CupertinoColors.systemGrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  //Kategorie Picker
  void _showCategoryPicker() {
    if (_isLoading) return;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions:
              _categories
                  .map(
                    (category) => CupertinoActionSheetAction(
                      child: Text(category),
                      onPressed: () {
                        setState(() {
                          _categoryController.text = category;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Abbrechen'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  //Datum Picker
  Future<void> _showDatePicker(
    BuildContext context, {
    required bool isPurchaseDate,
  }) async {
    if (_isLoading) return;

    final now = DateTime.now();
    DateTime initialDate =
        isPurchaseDate
            ? (_selectedPurchaseDate ?? now)
            : (_selectedWarrantyEndDate ?? now.add(const Duration(days: 365)));

    initialDate =
        initialDate.isBefore(DateTime(1900)) ? DateTime(1900) : initialDate;
    initialDate =
        initialDate.isAfter(DateTime(2100)) ? DateTime(2100) : initialDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: initialDate,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              minimumDate: DateTime(1900),
              maximumDate: DateTime(2100),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  if (isPurchaseDate) {
                    _selectedPurchaseDate = newDate;
                  } else {
                    _selectedWarrantyEndDate = newDate;
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  //Bild Picker
  Future<void> _pickImage() async {
    if (_isLoading) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  //Rechnung Picker
  Future<void> _pickInvoice() async {
    if (_isLoading) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedInvoice = File(pickedFile.path);
      });
    }
  }

  //Gerät hinzufügen
  Future<void> _addDevice() async {
    final User? currentUser = _userService.currentUser;
    if (currentUser == null) {
      print("Fehler: Benutzer nicht angemeldet.");
      _showErrorDialog('Benutzer nicht angemeldet. Bitte erneut anmelden.');
      return;
    }
    final String userId = currentUser.uid;

    if (_nameController.text.trim().isEmpty) {
      _showErrorDialog('Bitte einen Gerätenamen eingeben.');
      return;
    }
    if (_categoryController.text.isEmpty) {
      _showErrorDialog('Bitte eine Kategorie auswählen.');
      return;
    }
    if (_serialNumberController.text.trim().isEmpty) {
      _showErrorDialog('Bitte die Seriennummer eingeben.');
      return;
    }
    if (_selectedPurchaseDate == null) {
      _showErrorDialog('Bitte das Kaufdatum auswählen.');
      return;
    }
    if (_selectedWarrantyEndDate == null) {
      _showErrorDialog('Bitte den Garantiezeitraum (Enddatum) auswählen.');
      return;
    }
    if (_selectedPurchaseDate != null && _selectedWarrantyEndDate != null) {
      if (_selectedWarrantyEndDate!.isBefore(_selectedPurchaseDate!)) {
        _showErrorDialog(
          'Das Garantieende darf nicht vor dem Kaufdatum liegen.',
        );
        return;
      }
    }
    setState(() {
      _isLoading = true;
    });
    final String purchaseDateString = _storageDateFormatter.format(
      _selectedPurchaseDate!,
    );
    final String warrantyDateString = _storageDateFormatter.format(
      _selectedWarrantyEndDate!,
    );
    final String notes = _notesController.text.trim();
    final String name = _nameController.text.trim();
    final String category = _categoryController.text;
    final String serialNumber = _serialNumberController.text.trim();

    final Device deviceData = Device(
      userId: userId,
      category: category,
      name: name,
      purchaseDate: purchaseDateString,
      warrantyDate: warrantyDateString,
      serialNumber: serialNumber,
      image: null,
      invoice: null,
      warrantyExtension: null,
      notes: notes.isNotEmpty ? notes : null,
      timer: null,
    );

    try {
      await _deviceService.addDevice(
        deviceData,
        userId: userId,
        category: category,
        name: name,
        purchaseDate: purchaseDateString,
        warrantyDate: warrantyDateString,
        serialNumber: serialNumber,
        warrantyExtension: null,
        imageFile: _selectedImage,
        invoiceFile: _selectedInvoice,
        notes: notes.isNotEmpty ? notes : null,
        timer: null,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      print("Fehler beim Hinzufügen des Geräts: $error");
      if (mounted) {
        String errorMessage = 'Ein unbekannter Fehler ist aufgetreten.';
        if (error is FirebaseException) {
          errorMessage = 'Firebase Fehler: ${error.message ?? 'Unbekannt'}';
          if (error.code == 'permission-denied') {
            errorMessage =
                'Keine Berechtigung. Bitte prüfen Sie Ihre Anmeldung.';
          }
        } else {
          errorMessage =
              'Gerät konnte nicht hinzugefügt werden: ${error.toString()}';
        }

        _showErrorDialog(errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  //Fehler Dialog
  void _showErrorDialog(String message) {
    if (!mounted) return;
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text('Fehler'),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Gerät hinzufügen'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSectionHeader('Gerätedetails'),

                  // Gerätename Textfeld
                  CupertinoTextField(
                    controller: _nameController,
                    placeholder: 'Gerätename (z.B. iPhone 15 Pro)',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    readOnly: _isLoading,
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: CupertinoColors.systemGrey3,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  const SizedBox(height: 16),

                  // Kategorie Picker
                  CupertinoTextField(
                    controller: _categoryController,
                    placeholder: 'Kategorie',
                    readOnly: true,
                    onTap: _isLoading ? null : _showCategoryPicker,
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: CupertinoColors.systemGrey3,
                        width: 1,
                      ),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: const Icon(
                        CupertinoIcons.square_grid_2x2,
                        size: 18.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),

                  _buildSectionHeader('Garantie & Seriennummer'),
                  // Seriennummer Textfeld
                  CupertinoTextField(
                    controller: _serialNumberController,
                    placeholder: 'Seriennummer',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    readOnly: _isLoading,
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: CupertinoColors.systemGrey3,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  const SizedBox(height: 16),

                  // Kaufdatum Picker
                  CupertinoTextField(
                    controller:
                        _selectedPurchaseDate != null
                            ? TextEditingController(
                              text: _displayDateFormatter.format(
                                _selectedPurchaseDate!,
                              ),
                            )
                            : null,
                    placeholder: 'Kaufdatum',
                    readOnly: true,
                    onTap: () => _showDatePicker(context, isPurchaseDate: true),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: CupertinoColors.systemGrey3,
                        width: 1,
                      ),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: const Icon(CupertinoIcons.calendar, size: 18.0),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),

                  const SizedBox(height: 16),

                  // Garantieablauf Picker
                  CupertinoTextField(
                    placeholder:
                        _selectedWarrantyEndDate != null
                            ? _displayDateFormatter.format(
                              _selectedWarrantyEndDate!,
                            )
                            : 'Garantiezeitraum',
                    readOnly: true,
                    onTap:
                        () => _showDatePicker(context, isPurchaseDate: false),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: CupertinoColors.systemGrey3,
                        width: 1,
                      ),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: const Icon(
                        CupertinoIcons.calendar_today,
                        size: 18.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),

                  const SizedBox(height: 8),
                  _buildSectionHeader('Dokumente (optional)'),
                  Row(
                    children: [
                      // Bild hinzufügen Button
                      _buildFilePickerButton(
                        CupertinoIcons.camera,
                        'Bild hinzufügen',
                        _selectedImage,
                        _pickImage,
                      ),
                      const SizedBox(width: 16),
                      // Rechnung hinzufügen Button
                      _buildFilePickerButton(
                        CupertinoIcons.doc_text,
                        'Rechnung hinzufügen',
                        _selectedInvoice,
                        _pickInvoice,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Notizen Textfeld
                  CupertinoTextField(
                    controller: _notesController,
                    placeholder: 'Notizen (optional)',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                    readOnly: _isLoading,
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: CupertinoColors.systemGrey3,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),

                  const SizedBox(height: 32),
                  // Gerät hinzufügen Button
                  CupertinoButton.filled(
                    onPressed: _isLoading ? null : _addDevice,
                    child:
                        _isLoading
                            ? const CupertinoActivityIndicator(
                              color: CupertinoColors.white,
                            )
                            : const Text('Gerät hinzufügen'),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: CupertinoColors.black.withOpacity(0.1),
                child: const Center(
                  child: CupertinoActivityIndicator(radius: 20.0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
