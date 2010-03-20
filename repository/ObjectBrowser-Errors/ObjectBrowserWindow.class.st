Class {
	#name : #ObjectBrowserWindow,
	#superclass : #Object,
	#instVars : [
		'objectBrowser',
		'workspace',
		'methodEditor',
		'isWorkspaceSelected',
		'isMethodEditorSelected',
		'methodEditorButton',
		'workspaceButton'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserWindow class >> show: anObjectBrowser [
	self new show: anObjectBrowser 
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodEditor [
	methodEditor := (PluggableTextMorph
		on: (MethodEditorModel newOn: self objectBrowser)
		text: #selectedSelectorCode
		accept: #acceptCode:notifying:
		readSelection: nil
		menu: #menu:) setNameTo: #textoMetodo.
	^methodEditor
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodEditorButton [
	methodEditorButton := PluggableButtonMorph
		on: self
		getState: #isMethodEditorSelected
		action: #showMethodEditor
		label: #methodEditorButtonLabel.
	^methodEditorButton
]

{ #category : #view }
ObjectBrowserWindow >> buildMethodList [
	^ PluggableListMorph new
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
ObjectBrowserWindow >> buildObjectList [
	^ PluggableListMorph new
		on: (ObjectListModel newOn: self objectBrowser)
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
ObjectBrowserWindow >> buildVariableList [
	^ PluggableListMorph new
		on: (VariableListModel newOn: self objectBrowser)
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
ObjectBrowserWindow >> buildWorkspace [
	workspace := (ObjectBrowserPluggableTextMorph
		on: (ObjectBrowserWorkspaceStore new on: self objectBrowser)
		text: #contents
		accept: #accept:
		readSelection: nil
		menu: #codePaneMenu:shifted:) setNameTo: #workspace.
	^workspace
]

{ #category : #view }
ObjectBrowserWindow >> buildWorkspaceButton [
	workspaceButton := PluggableButtonMorph
		on: self
		getState: #isWorkspaceSelected
		action: #showWorkspace
		label: #workspaceButtonLabel.
	^workspaceButton
]

{ #category : #view }
ObjectBrowserWindow >> createView [
	| hSepFrac window |
	hSepFrac := 0.45.
	window := (SystemWindow labelled: 'Object Browser') model: self objectBrowser;
		
		addMorph: self buildObjectList
		frame: (0 @ 0 corner: 0.33 @ hSepFrac);
		
		addMorph: self buildVariableList
		frame: (0.33 @ 0 corner: 0.66 @ hSepFrac);
		
		addMorph: self buildMethodList
		frame: (0.66 @ 0 corner: 1 @ hSepFrac);
		
		addMorph: self buildWorkspaceButton
		frame: (0 @ hSepFrac corner: 0.25 @ (hSepFrac + 0.1));
		
		addMorph: self buildMethodEditorButton
		frame: (0.28 @ hSepFrac corner: 0.53 @ (hSepFrac + 0.1));
		
		addMorph: self buildObjectGraphButton
		frame: (0.56 @ hSepFrac corner: 0.81 @ (hSepFrac + 0.1));
		
		addMorph: self buildWorkspace
		frame: (0 @ (hSepFrac + 0.1) corner: 1 @ 1);
		
		addMorph: self buildMethodEditor
		frame: (0 @ (hSepFrac + 0.1) corner: 1 @ 1);
		
		position: 100 @ 100.
		
	self showMethodEditor.
	
	^window.
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow >> initialize [
	isMethodEditorSelected  := true.
	isWorkspaceSelected  := false.
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow >> isMethodEditorSelected [
	^isMethodEditorSelected 
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow >> isWorkspaceSelected [
	^isWorkspaceSelected
]

{ #category : #'as yet unclassified' }
ObjectBrowserWindow >> methodEditorButtonLabel [
	^'Method Editor'
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
	self objectBrowser: (ObjectBrowserModel newWithOB: anObjectBrowser).
	self createView openInWorld.
	
]

{ #category : #view }
ObjectBrowserWindow >> showMethodEditor [
	isMethodEditorSelected := true.
	isWorkspaceSelected := false.
	self swapTextEditors.
]

{ #category : #view }
ObjectBrowserWindow >> showWorkspace [
	isMethodEditorSelected := false.
	isWorkspaceSelected := true.
	self swapTextEditors.
]

{ #category : #view }
ObjectBrowserWindow >> swapTextEditors. [
	methodEditor visible:isMethodEditorSelected.
	workspace visible: isWorkspaceSelected .
	workspaceButton update: nil.
	methodEditorButton update: nil.
]

{ #category : #view }
ObjectBrowserWindow >> workspaceButtonLabel [
	^'Workspace'
]
