extends StaticBody2D
class_name barn

func lotado():
	var cont = 0
		
	for x in $area2d.get_overlapping_bodies():
		if x.is_in_group("animal"):
			cont += 1
			
	return cont == 4
