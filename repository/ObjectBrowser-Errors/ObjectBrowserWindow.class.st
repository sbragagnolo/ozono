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
ObjectBrowserWindow class >> menuCommandOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #'Object Browser')
		parent: #MostUsedTools;  
		action: [LOOPLesson openFreeLesson]
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
		lesson: objectBrowser lesson; 
		openLabel: objectBrowser title, ' - Workspace';
		containingWindow) center: World center.
]

{ #category : #view }
ObjectBrowserWindow >> workspaceButtonLabel [
	^'Open Workspace'
]
