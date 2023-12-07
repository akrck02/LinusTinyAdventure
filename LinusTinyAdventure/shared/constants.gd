class_name Constants

# Project paths
const SCRIPT_PATH = "res://scripts/"
const SCENE_PATH = "res://scenes/"
const LEVELS_PATH = SCENE_PATH + "levels/"
const NODE_PATH = "res://nodes/"
const UI_NODE_PATH = NODE_PATH + "ui/"
const SPRITE_PATH = "res://sprites/"
const UI_SPRITE_PATH = SPRITE_PATH + "ui/"

# script paths
const CONTROLS_SCRIPT_PATH = SCRIPT_PATH + "mechanics/controls.gd"
const DIRECTION_SCRIPT_PATH = SCRIPT_PATH + "mechanics/direction.gd"
const ENGINE_UTILS_SCRIPT_PATH = SCRIPT_PATH + "shared/engine_utils.gd"

# Scene paths
const SELECTOR = "selector.tscn"
const ERROR = "error.tscn"
const CREDITS = "credits.tscn"
const LOADER = "loader.tscn"

# Nodes
const LEVEL_BUTTON = UI_NODE_PATH + "levelbutton.tscn"

# Sprites
const DILOGUE_FILE_TEMPLATE : String = "res://files/dialogues/$file.json"

# Sprite params
const TILE_SIZE = 16

# Audio 
const AUDIO_MASTER_BUS = "Master";
const AUDIO_MUSIC_BUS = "Music";
const AUDIO_EFFECTS_BUS = "Effects";
