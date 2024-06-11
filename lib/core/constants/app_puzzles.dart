// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppPuzzles {
  static const _prefix = "assets/images/puzzle/";
  static final puzzle1 = PuzzleData(
    image: "${_prefix}image_1/puzzle_image_1.png",
    parts: List.generate(
      16,
      (index) => "${_prefix}image_1/puzzle_image_1_${index + 1}.png",
    ),
  );
  static final puzzle2 = PuzzleData(
    image: "${_prefix}image_2/puzzle_image_2.png",
    parts: List.generate(
      16,
      (index) => "${_prefix}image_2/puzzle_image_2_${index + 1}.png",
    ),
  );
  static final puzzle3 = PuzzleData(
    image: "${_prefix}image_3/puzzle_image_3.png",
    parts: List.generate(
      16,
      (index) => "${_prefix}image_3/puzzle_image_3_${index + 1}.png",
    ),
  );
  static final puzzle4 = PuzzleData(
    image: "${_prefix}image_4/puzzle_image_4.png",
    parts: List.generate(
      16,
      (index) => "${_prefix}image_4/puzzle_image_4_${index + 1}.png",
    ),
  );

  static final List<PuzzleData> puzzles = [puzzle1, puzzle2, puzzle3, puzzle4];
}

class PuzzleData {
  final String image;
  final List<String> parts;
  const PuzzleData({
    required this.image,
    required this.parts,
  });
}
