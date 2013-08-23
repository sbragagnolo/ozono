Class {
	#name : #RecicleBinOrganization,
	#superclass : #Object,
	#instVars : [
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
RecicleBinOrganization class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
RecicleBinOrganization >> asString [
	^'Papelera' translated 
]

{ #category : #'as yet unclassified' }
RecicleBinOrganization >> icon [
	^OBIcons trashIcon
]

{ #category : #'as yet unclassified' }
RecicleBinOrganization >> makeSelectionOn: anObjectBrowser [ 
	
]

{ #category : #'as yet unclassified' }
RecicleBinOrganization >> menu: aMenu [
	^aMenu addList: (OrderedCollection with: (Array braceWith: 'Recolectar basura' translated with: #runGarbageCollector))
]

{ #category : #'as yet unclassified' }
RecicleBinOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser
]

{ #category : #'as yet unclassified' }
RecicleBinOrganization >> treeContents [
	^objectBrowser orphanObjects collect: [ :o | OBListItemWrapper with: o model: o ]
]
