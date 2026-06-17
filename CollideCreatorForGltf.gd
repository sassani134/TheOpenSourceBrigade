extends SceneTree

# https://dev.to/ramchale/godot-batch-generation-of-collision-meshes-from-gtlf-model-files-4noh
# ../godot/Godot_v4.2.1-stable_win64_console.exe -s collidable_from_gltf.gd
# path to change
# windows
# C:\Users\nigaz\Desktop\Godot_v4.6.3-stable_win64.exe -

func create_collidable_from_gltf(gltf_path: String, destination_path: String) -> void:
	print("Creating " + destination_path + " from " + gltf_path)

	# Load the imported gltf and get the MeshInstance3D node, assuming it's the first child node
	var model_resouce = ResourceLoader.load(gltf_path) as PackedScene
	var model_scene = model_resouce.instantiate()
	var source_mesh = model_scene.get_child(0)

	# Copy the mesh as the new root node
	var mesh_node = source_mesh.duplicate() as MeshInstance3D;
	# Create a collision shape (consider using a simpler shape if you care about performance)
	mesh_node.create_trimesh_collision()

	var scene = PackedScene.new()

	var result = scene.pack(mesh_node)

	if result == OK:
		var error = ResourceSaver.save(scene, destination_path)
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")

	# Free the resources (not doing this will show leaks running this from the command line)
	mesh_node.queue_free()
	model_scene.queue_free()

func get_gltf_file_names(directory: String) -> Array:
	var files = DirAccess.get_files_at(directory)

	var result = []

	for file in files:
		if (file.ends_with(".gltf")):
			result.append(file)

	return result

func _init() -> void:
	var source_directory = "res://models/landscape"
	var destination_directory = "res://meshes/landscape"

	# Make sure this directory exists
	DirAccess.make_dir_recursive_absolute(destination_directory)

	var files = get_gltf_file_names(source_directory)
	for file in files:
		# Chop off the file extension
		var name = file.substr(0, file.length() - 5)

		create_collidable_from_gltf(source_directory + "/" + file, destination_directory + "/" + name + ".tscn")

	quit()
