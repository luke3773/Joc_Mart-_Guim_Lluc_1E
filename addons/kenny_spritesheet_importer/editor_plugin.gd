@tool
extends EditorPlugin

var import_plugin = null

func _enter_tree():
	import_plugin = preload("import_plugin.gd").new()
	# Initialization of the plugin goes here.
	add_import_plugin(import_plugin)


func _exit_tree():
	remove_import_plugin(import_plugin)
	import_plugin = null
