tool
extends Control  # Oder irgendeine andere Control-basierte Klasse, die für die Verwendung im Editor geeignet ist

@export_file("*.json") var d_file

var dialogue = []

func _ready():
	start()

func start():
	dialogue = load_dialogue()

	$NinePatchRect/name.text = dialogue[0]['name']
	$NinePatchRect/text.text = dialogue[0]['text']

func load_dialogue() -> Array:
	var file = File.new()
	if file.file_exists(d_file):
		file.open(d_file, File.READ)
		var content = file.get_as_text()
		file.close()
		return parse_json(content)
	else:
		print("File not found: ", d_file)
		return []

func parse_json(json_str: String) -> Array:
	var parsed = JSONParser.new()
	var result = parsed.parse(json_str)
	if result == OK:
		return parsed.get_node().get_array()
	else:
		print("Error parsing JSON")
		return []
