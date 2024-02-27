import 'package:flame/components.dart';

class Edge {
  Vector2 start;
  Vector2 end;

  Edge(this.start, this.end);

  // Method to get the perpendicular axis
  Vector2 getPerpendicularAxis() {
    // Calculate the direction of the edge
    Vector2 direction = end.clone()..sub(start);

    // Calculate the perpendicular axis by swapping x and y components and negating one of them
    Vector2 perpendicularAxis = Vector2(-direction.y, direction.x);

    // Normalize the perpendicular axis
    perpendicularAxis.normalize();

    return perpendicularAxis;
  }

  // Other methods...
}
