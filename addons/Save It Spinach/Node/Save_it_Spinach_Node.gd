@tool
extends Node

@export var autoload_name : String = "Global"
@export var Varname: PackedStringArray
@onready var autoload = get_node("/root/" + autoload_name)
var _1data = {}

const Save_Dir = "user://saves/"

var save_path = Save_Dir + "save.dat"

func _ready():
	load_data()

func Arrays_To_Dict():
	for n in Varname.size():
		var extracted = autoload.get(Varname[n])
		_1data[Varname[n]] = extracted

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		Arrays_To_Dict()
		save_data()

func save_data():
	var _data = {}
	_data = _1data
	DirAccess.make_dir_absolute(Save_Dir)

	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(_data)

func load_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if(file != null):
		var _data = file.get_var()
		load_save_stats(_data)
		file.close()

func load_save_stats(stats):
	for n in Varname.size():
		var key = stats[str(Varname[n])] 
		autoload.set(Varname[n], key)
