gml_pragma("global", "____tools()")

enum Tools {
	tilePencil,
	tileBrush,
	tileSelector,
	objectPlacer,
	objectSelector,
	collisionEditor,
	zoneEditor,
}

global.__tool_name = []
global.__tool_data = []

__tool_init(Tools.tilePencil, "tilePencil")
__tool_init(Tools.tileBrush, "tileBrush")
__tool_init(Tools.tileSelector, "tileSelector")

__tool_init(Tools.collisionEditor, "colPencil")
__tool_init(Tools.zoneEditor, "zoneEditor")

__tool_init(Tools.objectPlacer, "objectPlacer")
__tool_init(Tools.objectSelector, "zoneEditor")

global.mode_tools = [
	[],
	[Tools.tilePencil, Tools.tileBrush],//, Tools.tileSelector],
	[Tools.collisionEditor],//, Tools.zoneEditor],
	[Tools.objectPlacer],//, Tools.objectSelector]
]