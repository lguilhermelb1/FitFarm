extends StaticBody2D
class_name barn


func lotado():
	print($area2d.get_overlapping_bodies())
	print($area2d.get_overlapping_areas())
	return len($area2d.get_overlapping_areas()) ==4

