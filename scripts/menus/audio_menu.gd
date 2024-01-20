extends TabBar



#linkea el volumen de buss master con la barra
func _on_master_value_changed(value):
	set_volume(0, value)

#linkea el volumen de buss music con la barra
func _on_music_value_changed(value):
	set_volume(1, value)

#linkea el volumen de buss SFX con la barra
func _on_sfx_value_changed(value):
	set_volume(2, value)


#cambia el valor del bus con el valor de la barra
func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
