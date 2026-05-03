import 'package:flutter/material.dart';

class RatingCard extends StatefulWidget {
  final String name;
  final String bio;
  final String imageUrl;
  final double rating;
  final Function(double)? onRatingChanged;
  final Function(double)? onSubmit;

  const RatingCard({
    super.key,
    required this.name,
    required this.bio,
    required this.imageUrl,
    this.rating = 0,
    this.onRatingChanged,
    this.onSubmit,
  });

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: widget.imageUrl.isNotEmpty
                ? NetworkImage(widget.imageUrl)
                : null,
            child: widget.imageUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.grey, size: 32)
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.bio,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => _currentRating = index + 1.0);
                        widget.onRatingChanged?.call(_currentRating);
                      },
                      child: Icon(
                        index < _currentRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 26,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: _currentRating > 0
                        ? () => widget.onSubmit?.call(_currentRating)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E78),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Submit Rating",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}