Class {
	#name : #ObjectBrowserWindow,
	#superclass : #Object,
	#instVars : [
		'objectBrowser',
		'methodEditor',
		'methodEditorButton',
		'workspaceButton',
		'garbageCollectionButton'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> icon [
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self iconContents readStream).
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> iconContents [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAFo9M/3AAAAAXNSR0IArs4c6QAAAAZiS0dE
AP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9oIFQQZHdfJFJgAAAJV
SURBVDjLrZJJSNQBFMZ//5k/hS1jo5ZK4KEsKrIMQQxPNm3HpMWihXI61EGCaqTCoghpQ8Eg
IgwyU5KKjAgtIgtKyoIypjShxRIbJ5tySWdxnK+DmZRFl77Le3x8b3+GJAAsAIt2X5AxzJgo
rLxD5SCJ3AuPJUkFZ2plAny5X0dVVDcZ8X5+xgzDMmSkR+43AjDXHL6sIFb0uZ3rJXlYLu1f
bRgeD8HOXoBfc5TefaWgP8DyuYkkJ8UbP7KJ7aV18no8GrvlnCZtLtXx8hpNduRLEiZApj3E
gdKbzA97aTi/i8HQALU1jaNL/An/FJjDzssPn3WnycN4YxDnslTjp0ISW8vqdfv5Ww3DeaJa
kpA0JLDmlKjo4i3ZnGWyrT0pSTpw6vrIFOvnTaHtUx+OpAm0e4Io2I+/+9tIDy2tX7l6cCV3
GppJzZ5D/rFKFsyIGxEcXpHEhn0VmJEA9QkT6O3qYcemJf9pD/+C+Tuxr/qZ7LbxpMSOITbK
xJDo7gvw9J2PsN/P3o1Zxh8eCF687ZCxuUwJ1gAux0w8ng6OVD+m8MpDXr//iGtVBlNtVmyO
ArW2eTVqhExXpSLhfh4U5rCu6AZuXwRfVx+R0ADWyCCJpp/Gij0sdR4jJjqaquJtxi8dZE6L
wTIgekLgyk5niiXM3LgoHNPGsXj6RApzs/B1dqKwSE1OGL2DnDQ7ze5mVrjK8Qf6mZ0UQ9HO
lcTF2vF6Ozl6+hrFZ+tIiIaFsyb+/QotL9y619DEk6YOfF/9SBEm28aQnjKVjLSZpCxIM/7r
Gb8DeEs6z/3CU5IAAAAASUVORK5CYII='
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> menuCommandOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #'Object Browser')
		parent: #MostUsedTools;  
		action: [LOOPLesson openFreeLesson];
		icon: self icon.
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> show: anObjectBrowser [
	self new show: anObjectBrowser 
]

{ #category : #view }
ObjectBrowserWindow >> buildGarbageCollectionButton [
	garbageCollectionButton := PluggableButtonMorph
		on: self objectBrowser 
		getState: nil
		action: #runGarbageCollector
		label: #garbageCollectorButtonLabel.
	^garbageCollectionButton
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodEditor [
	| model |
	methodEditor := (PluggableTextMorph
		on: (model := MethodEditorModel newOn: self objectBrowser )
		text: #selectedMethodCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoMetodo.
	model methodEditorMorph: methodEditor.
	^methodEditor
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodList [
	^ OBPluggableListMorph new
		on: (MethodListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
]

{ #category : #view }
ObjectBrowserWindow >> buildObjectAttributeList [
	^ PluggableListMorph new
		on: (ObjectAttributeListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
]

{ #category : #view }
ObjectBrowserWindow >> buildObjectGraphButton [
	| objectGraphButton |
	objectGraphButton := PluggableButtonMorph
		on: self objectBrowser
		getState: nil
		action: #showObjectGraph.
	objectGraphButton label: self objectGraphButtonLabel .
	^objectGraphButton 
]

{ #category : #view }
ObjectBrowserWindow >> buildVariableList [
	^ PluggableListMorph new
		on: (VariablesListModel newOn: self objectBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
]

{ #category : #view }
ObjectBrowserWindow >> buildWorkspaceButton [
	workspaceButton := PluggableButtonMorph
		on: self
		getState: nil
		action: #showWorkspace
		label: #workspaceButtonLabel.
	^workspaceButton
]

{ #category : #view }
ObjectBrowserWindow >> createView [
	| hSepFrac window |
	hSepFrac := 0.45.
	window := (SystemWindow labelled: self objectBrowser title, ' - Object Browser') model: self objectBrowser;
		
		addMorph: self buildVariableList 
		frame: (0 @ 0 corner: 0.33 @ hSepFrac);
		
		addMorph: self buildObjectAttributeList 
		frame: (0.33 @ 0 corner: 0.66 @ hSepFrac);
		
		addMorph: self buildMethodList
		frame: (0.66 @ 0 corner: 1 @ hSepFrac);
		
		
		addMorph: self buildWorkspaceButton
		frame: (0 @ hSepFrac corner: 0.25 @ (hSepFrac + 0.1));
		
		addMorph: self buildGarbageCollectionButton
		frame: (0.26 @ hSepFrac corner: 0.51 @ (hSepFrac + 0.1));
		
		addMorph: self buildObjectGraphButton
		frame: (0.56 @ hSepFrac corner: 0.81 @ (hSepFrac + 0.1));
		
		addMorph: self buildMethodEditor
		frame: (0 @ (hSepFrac + 0.1) corner: 1 @ 1);
		
		center: World center.
	
	^window.
]

{ #category : #view }
ObjectBrowserWindow >> objectBrowser [
	^objectBrowser 
]

{ #category : #view }
ObjectBrowserWindow >> objectBrowser: anObjectBrowser. [
	objectBrowser := anObjectBrowser 
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow >> objectGraphButtonLabel [
	^'Object Diagram'
]

{ #category : #view }
ObjectBrowserWindow >> show: anObjectBrowser [ 
	self objectBrowser: anObjectBrowser.
	self createView openInWorld.
	
]

{ #category : #view }
ObjectBrowserWindow >> showWorkspace [
	(LOOPWorkspace new 
		openLabel: objectBrowser title, ' - Workspace';
		lesson: objectBrowser lesson; 
		containingWindow) center: World center.
]

{ #category : #view }
ObjectBrowserWindow >> workspaceButtonLabel [
	^'Open Workspace'
]
