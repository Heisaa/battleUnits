extends TextureButton

signal wasPressed

func  _pressed():
	emit_signal("wasPressed")

func connectMe(obj, unitName):
	connect("wasPressed", obj, "wasPressed", [self])
	name = unitName
	$label.text = unitName