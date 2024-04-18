
@tool
extends EditorImportPlugin

enum Presets { DEFAULT }

func _get_importer_name():
    return "iseesharp83.kenney.spritesheet.importer"

func _get_visible_name():
    return "Kenney Spritesheet"

func _get_recognized_extensions():
    return ["png"]

func _get_priority():
    return 0.5

func _get_import_order():
    return 0

func _get_save_extension():
    return "res"

func _get_resource_type():
    return "Resource"

func _get_preset_count():
    return Presets.size()

func _get_preset_name(preset_index):
    match preset_index:
        Presets.DEFAULT: return "Default"

func _get_import_options(path, preset_index):
    var options := [
            {
                "name": "spritesheet_xml_file",
                "default_value": path.replacen(".png", ".xml"),
                "property_hint": PROPERTY_HINT_FILE,
                "hint_string": "*.xml"
            },
            {
                "name": "destination_folder",
                "default_value": path.get_basename(),
                "property_hint": PROPERTY_HINT_DIR
            }]
    match preset_index:
        Presets.DEFAULT:
            return options
        _:
            return []

func _get_option_visibility(path, option_name, options):
    return true

func _import(source_file, save_path, options, platform_variants, gen_files):
    var atlas = read_kenney_sprite_sheet(options.spritesheet_xml_file)
    var folder = options.destination_folder
    create_folder(folder)
    
    var full_image = ImageTexture.create_from_image(Image.load_from_file(source_file))
    
    if not full_image:
        printerr("Failed to load image file: " + source_file)
        return ERR_FILE_NOT_FOUND
    
    create_atlas_textures(folder, full_image, atlas, gen_files)
    return ResourceSaver.save(Resource.new(), "%s.%s" % [save_path, _get_save_extension()])

func create_folder(folder):
    var dir := DirAccess.open("res://")
    if not dir.dir_exists(folder):
        if not dir.make_dir_recursive(folder) == OK:
            printerr("Failed to create folder: " + folder)

func create_atlas_textures(folder, full_image, atlas, gen_files):
    for sprite in atlas.sprites:
        if not create_atlas_texture(folder, full_image, sprite, gen_files):
            return false
    return true

func create_atlas_texture(folder, full_image, sprite, gen_files):
    var name = "%s/%s.%s" % [folder, sprite.name.get_basename(), "tres"]
    var texture
    if ResourceLoader.exists(name, "AtlasTexture"):
        texture = ResourceLoader.load(name, "AtlasTexture")
    else:
        texture = AtlasTexture.new()
    
    texture.atlas = full_image
    texture.region = Rect2(sprite.x, sprite.y, sprite.width, sprite.height)
    gen_files.push_back(name)
    return save_resource(name, texture)

func save_resource(name, texture):
    create_folder(name.get_base_dir())
    var status = ResourceSaver.save(texture, name)
    if status != OK:
        printerr("Failed to save resource " + name)
        return false
    return true


func read_kenney_sprite_sheet(source_file):
    var atlas = null
    var sprites = []
    var parser = XMLParser.new()
    if OK == parser.open(source_file):
        var read = parser.read()
        if read == OK:
            atlas = {}
            atlas["sprites"] = sprites
        while read != ERR_FILE_EOF:
            if parser.get_node_type() == XMLParser.NODE_ELEMENT:
                var node_name = parser.get_node_name()
                match node_name:
                    "TextureAtlas":
                        var imagePath = parser.get_named_attribute_value("imagePath")
                    "SubTexture":
                        var sprite = {}
                        sprite['name'] = parser.get_named_attribute_value("name")
                        sprite['x'] = float(parser.get_named_attribute_value("x"))
                        sprite['y'] = float(parser.get_named_attribute_value("y"))
                        sprite['width'] = float(parser.get_named_attribute_value("width"))
                        sprite['height'] = float(parser.get_named_attribute_value("height"))
                        sprites.append(sprite)
            read = parser.read()
    return atlas


