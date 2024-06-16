import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> allAvatarImages = [
  'lib/images/splash.png',
  'lib/images/ava2.png',
  'lib/images/ava3.png',
  'lib/images/ava4.png',
  'lib/images/ava5.png',
];

class Avatar extends StatefulWidget {
  final Function(int) onAvatarSelected;
  final int initialAvatarIndex;

  const Avatar(
      {super.key, required this.onAvatarSelected, this.initialAvatarIndex = 0});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late int selectedAvatarIndex;
  bool isExpanded = false;

  @override
  void initState() {
    selectedAvatarIndex = widget.initialAvatarIndex;
    super.initState();
    _loadAvatarIndex();
  }
  _loadAvatarIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAvatarIndex = prefs.getInt('avatarIndex') ?? widget.initialAvatarIndex;
    });
  }

  _saveAvatarIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('avatarIndex', index);
  }

  void _changeAvatar(int index) {
    setState(() {
      selectedAvatarIndex = index;
      _saveAvatarIndex(index); // Сохраняем выбранный индекс аватара
      widget.onAvatarSelected(selectedAvatarIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(allAvatarImages[selectedAvatarIndex]),
            radius: 50,
          ),
          if (isExpanded)
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allAvatarImages.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    _changeAvatar(index);
                    setState(() {
                      isExpanded = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(allAvatarImages[index]),
                      radius: 30,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
