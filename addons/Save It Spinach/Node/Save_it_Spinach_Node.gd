tool
extends Node

export(String) var autoload_name
export(Array) var Key
export(Array) var Value
onready var autoload = get_node("/root/" + autoload_name)
var _1data = {}

const Save_Dir = "user://saves/"

var save_path = Save_Dir + "save.dat"

func _ready():
	load_data()

func Arrays_To_Dict():
	for n in Value.size():
		var extracted = autoload.get(Value[n])
		_1data[Key[n]] = extracted

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		Arrays_To_Dict()
		save_data()

func save_data():
	var _data = {}
	_data = _1data
	var dir = Directory.new()
	if !dir.dir_exists(Save_Dir):
		dir.make_dir_recursive(Save_Dir)

	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(_data)
		file.close()

func load_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var _data = file.get_var()
			load_save_stats(_data)
			file.close()

func load_save_stats(stats):
	for n in Value.size():
		var key = stats[str(Key[n])] 
		autoload.set(Value[n], key)
