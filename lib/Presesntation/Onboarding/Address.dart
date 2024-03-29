import 'package:address/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _countryController =
      TextEditingController.fromValue(const TextEditingValue(text: 'US'));
  final _formLangController =
      TextEditingController.fromValue(const TextEditingValue(text: 'en'));
  final _nameController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _zoneController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _displayLangController =
      TextEditingController.fromValue(const TextEditingValue(text: 'en'));

  Map<AddressFormField, TextEditingController> get _formFieldToControllerMap =>
      {
        AddressFormField.fullName: _nameController,
        AddressFormField.addressLine1: _addressLine1Controller,
        AddressFormField.addressLine2: _addressLine2Controller,
        AddressFormField.city: _cityController,
        AddressFormField.zone: _zoneController,
        AddressFormField.postalCode: _postalCodeController,
      };

  @override
  void initState() {
    super.initState();
    _countryController
        .addListener(() => setState(() => _zoneController.text = ''));
    _formLangController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final addressFormatter = AddressFormatter(_formLangController.text);
    final formFormat = addressFormatter.formatForm(_countryController.text);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _countryController,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'Address country (ISO 3166-1 alpha-2)',
            helperText: 'US, CA, AU, PL, FR, IT, ES...',
          ),
        ),
        TextField(
          controller: _formLangController,
          textCapitalization: TextCapitalization.none,
          decoration: const InputDecoration(
            labelText: 'Form language (ISO 639-1)',
            helperText: 'en, fr, pl, es...',
          ),
        ),
        const Divider(height: 48),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final field in formFormat)
              if (field.availableValues != null)
                DropdownButtonFormField<String>(
                  value: _formFieldToControllerMap[field.type]!.text,
                  onChanged: (value) {
                    if (value == null) return;
                    _formFieldToControllerMap[field.type]!.text = value;
                  },
                  items: [
                    const DropdownMenuItem(value: '', child: SizedBox()),
                    for (final value in field.availableValues!.entries)
                      DropdownMenuItem(
                        value: value.key,
                        child: Text(value.value),
                      ),
                  ],
                  decoration: InputDecoration(
                    labelText: field.label,
                    helperText: field.description,
                  ),
                )
              else
                TextField(
                  controller: _formFieldToControllerMap[field.type],
                  decoration: InputDecoration(
                    labelText: field.label,
                    helperText: field.description,
                  ),
                ),
          ],
        ),
        const Divider(height: 48),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _displayLangController,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  labelText: 'Display language (ISO 639-1)',
                  helperText: 'en, fr, pl, es...',
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                final formatter = AddressFormatter(_displayLangController.text);

                final address = Address();

                //final displayFormatted = formatter.formatDisplay();

                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) => Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Text(displayFormatted.join('\n')),
                //   ),
                // );
              },
              child: const Text('FORMAT DISPLAY'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _countryController.dispose();
    _formLangController.dispose();

    _nameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _zoneController.dispose();
    _postalCodeController.dispose();

    _displayLangController.dispose();

    super.dispose();
  }
}
