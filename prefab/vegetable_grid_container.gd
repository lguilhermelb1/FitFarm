extends GridContainer
class_name vegetables_grid

func lotado():
	for x in get_children():
		if x.get_child_count() == 0:
			return false
	return true

func _sem_filhos() -> Control:
	for x in get_children():
		if x.get_child_count() == 0:
			return x	
	return null

func inserir(nd: Node2D):
	var nd_insercao = _sem_filhos()
	if nd_insercao != null:
		nd_insercao.add_child(nd)
