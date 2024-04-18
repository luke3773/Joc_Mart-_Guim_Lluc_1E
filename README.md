# Kenney Spritesheet Importer

Supports Godot 4.1/4.2

## Usage

Click on a png, and choose the 'Kenney Spritesheet' option under Import. Verify the options and (re)import.

## Files

This will take the spritesheet and use the provided xml from Kenney (with <TextureAtlas> and <SubTexture> nodes) and create AtlasTexture resource files into the destination folder. You can then use these textures in your project. They'll be named according to the names supplied in the xml file.